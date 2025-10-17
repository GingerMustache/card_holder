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
  });
}

const _dbName = "card_hold.db";
const _cardTable = "card";
const _idColumn = "id";
const _name = "name";
const _color = "color";
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
    required int color,
    required String? urlPath,
    required double logoSize,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final currentCard = await getCard(id: id);

    final updateColumn = await db.update(
      _cardTable,
      {
        _codeColumn: code,
        _name: name,
        _color: color,
        _urlPath: urlPath,
        _logoSize: logoSize,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

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

    final updatedCard = await db.update(
      _cardTable,
      {_usagePointColumn: currentCard.usagePoint + 1},
      where: 'id = ?',
      whereArgs: [id],
    );

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
    final cards = await db.query(
      _cardTable,
      orderBy: '$_usagePointColumn DESC',
    );

    return cards.map((cardRow) => DataBaseCard.fromRow(cardRow)).toList();
  }

  @override
  Future<DataBaseCard> getCard({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final cards = await db.query(
      _cardTable, // где в базе искать
      limit: 1, // сколько
      where: "id = ?", // где в колонке noteTable искать
      whereArgs: [id], // аргумент поиска
    );

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
    // what happened in case of empty notes list?
  }

  @override
  Future<void> deleteCard({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final deletedCount = await db.delete(
      _cardTable,
      where: "id = ?",
      whereArgs: [id],
    );
    if (deletedCount == 0) {
      throw CouldNotDeleteCard();
    } else {
      // .removeWhere удаляет в листе 'типа', те значения, которые соответсвуют условию
      // в данном случае, в DataBaseNote есть id'шник, который мы получим в параметры функции
      // и по нему мы удалим заметку
    }
  }

  @override
  Future<DataBaseCard> createCard({
    required String code,
    required String name,
    required int color,
    required String urlPath,
    required double logoSize,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final cardId = await db.insert(_cardTable, {
      _codeColumn: code.replaceAll(' ', ''),
      _name: name,
      _color: color,
      _usagePointColumn: 0,
      _urlPath: urlPath,
      _logoSize: logoSize,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    return DataBaseCard(
      id: cardId,
      color: color,
      code: code,
      name: name,
      usagePoint: 0,
      urlPath: urlPath,
      logoSize: logoSize,
    );
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
    if (_db != null) {
      throw DatabaseIsAlreadyOpen();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, _dbName);

      final db = await openDatabase(
        dbPath,
        version: 3, // bump version when adding db_meta
        onCreate: (db, version) async {
          await db.execute(_createCardTable);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute('''
            CREATE TABLE IF NOT EXISTS db_meta (
              version INTEGER
            )
          ''');
          }
          if (oldVersion < 3) {
            await db.execute('''ALTER TABLE "card" ADD COLUMN "logo_size" REAL''');
          }
        },
      );

      _db = db;
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
