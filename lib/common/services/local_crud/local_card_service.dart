// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:card_holder/common/services/local_crud/exceptions/crud_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

part '../local_crud/model/data_base_card.dart';

abstract class CardServiceAbstract {
  Future<DataBaseCard> updateCard({
    required int id,
    required String code,
    required String name,
    required int color,
    required String? urlPath,
    required double logoSize,
    required CardCodeType cardCodeType,
  });
  Future<DataBaseCard> getCard({required int id});
  Future<DataBaseCard> openCard({required int id});
  Future<List<DataBaseCard>> getCards();
  Future<int> deleteAllCards();
  Future<void> deleteCard({required int id});
  Future<DataBaseCard> createCard({
    required String code,
    required String name,
    required int color,
    required String urlPath,
    required double logoSize,
    required CardCodeType cardCodeType,
  });
}

const _dbName = "card_hold.db";
const _cardTable = "card";
const _idColumn = "id";
const _name = "name";
const _color = "color";
const _cardCodeTypeColumn = "card_code_type";
const _codeColumn = "code";
const _usagePointColumn = "usage_point";
const _urlPath = "url_path";
const _logoSize = "logo_size";

const _createCardTable = '''
      CREATE TABLE IF NOT EXISTS "card" (
      "color" INTEGER NOT NULL,
      "id"	INTEGER NOT NULL,
      "code"	TEXT,
      "name"	TEXT,
      "card_code_type" TEXT,
      "usage_point" INTEGER,
      "url_path"	TEXT,
      "logo_size" REAL,
      PRIMARY KEY("id" AUTOINCREMENT)
      );''';

class LocalCardService implements CardServiceAbstract {
  Database? _db;

  static final LocalCardService _shared = LocalCardService._sharedInstance();
  LocalCardService._sharedInstance();
  factory LocalCardService() => _shared;

  @override
  Future<DataBaseCard> updateCard({
    required int id,
    required String code,
    required String name,
    required CardCodeType cardCodeType,
    required int color,
    required String? urlPath,
    required double logoSize,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final currentCard = await getCard(id: id);
    int updateColumn;

    try {
      updateColumn = await db.update(
        _cardTable,
        {
          _codeColumn: code,
          _name: name,
          _cardCodeTypeColumn: cardCodeType.name,
          _color: color,
          _urlPath: urlPath,
          _logoSize: logoSize,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CouldNotUpdateCard(e.toString());
    }

    if (updateColumn == 0) {
      throw CouldNotUpdateCard();
    } else {
      return currentCard;
    }
  }

  @override
  Future<DataBaseCard> openCard({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final currentCard = await getCard(id: id);

    int updatedCard;
    try {
      updatedCard = await db.update(
        _cardTable,
        {_usagePointColumn: currentCard.usagePoint + 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CouldNotOpenCard(e.toString());
    }

    if (updatedCard == 0) {
      throw CouldNotOpenCard();
    } else {
      return currentCard;
    }
  }

  @override
  Future<List<DataBaseCard>> getCards() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    try {
      final cards = await db.query(
        _cardTable,
        orderBy: '$_usagePointColumn DESC',
      );

      return cards.map((cardRow) => DataBaseCard.fromRow(cardRow)).toList();
    } catch (e) {
      throw CouldNotFetchCards(e.toString());
    }
  }

  @override
  Future<DataBaseCard> getCard({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    List<Map<String, Object?>> cards;

    try {
      cards = await db.query(
        _cardTable, // где в базе искать
        limit: 1, // сколько
        where: "id = ?", // где в колонке noteTable искать
        whereArgs: [id], // аргумент поиска
      );
    } catch (e) {
      throw CouldNotFindCard(e.toString());
    }

    if (cards.isEmpty) {
      throw CouldNotFindCard();
    } else {
      final card = DataBaseCard.fromRow(cards.first);

      return card;
    }
  }

  @override
  Future<int> deleteAllCards() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final numberOfDeletions = await db.delete(_cardTable);
    return numberOfDeletions;
  }

  @override
  Future<void> deleteCard({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    int deletedCount;
    try {
      deletedCount = await db.delete(
        _cardTable,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      throw CouldNotDeleteCard(e.toString());
    }

    if (deletedCount == 0) {
      throw CouldNotDeleteCard();
    } else {
      // .removeWhere удаляет в листе 'типа', те значения, которые соответсвуют условию
      // в данном случае, в DataBaseNote есть id'шник, который мы получим в параметры функции
      // и по нему мы удалим карту
    }
  }

  @override
  Future<DataBaseCard> createCard({
    required String code,
    required String name,
    required int color,
    required String urlPath,
    required double logoSize,
    required CardCodeType cardCodeType,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    try {
      final cardId = await db.insert(_cardTable, {
        _codeColumn: code.replaceAll(' ', ''),
        _name: name,
        _color: color,
        _cardCodeTypeColumn: cardCodeType.name,
        _usagePointColumn: 0,
        _urlPath: urlPath,
        _logoSize: logoSize,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      return DataBaseCard(
        id: cardId,
        color: color,
        code: code,
        name: name,
        cardCodeType: cardCodeType,
        usagePoint: 0,
        urlPath: urlPath,

        logoSize: logoSize,
      );
    } catch (e) {
      throw CouldNotCreateCard(e.toString());
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseIsAlreadyOpen {
      // empty
    }
  }

  Future<void> open() async {
    if (_db != null) throw DatabaseIsAlreadyOpen();

    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, _dbName);

      final db = await openDatabase(
        dbPath,
        version: 4, // bump version when adding db_meta
        onCreate: (db, version) async {
          await db.execute(_createCardTable);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 3) {
            await db.execute('''
            CREATE TABLE IF NOT EXISTS db_meta (
              version INTEGER
            )
          ''');
          }
          if (oldVersion < 3) {
            await db.execute(
              '''ALTER TABLE "card" ADD COLUMN "logo_size" REAL''',
            );
          }
          if (oldVersion < 4) {
            await db.execute(
              '''ALTER TABLE "card" ADD COLUMN "card_code_type" TEXT''',
            );
            await db.execute(
              '''UPDATE "card" SET "card_code_type" = 'barcode' WHERE "card_code_type" IS NULL''',
            );
          }
        },
      );

      _db = db;
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
