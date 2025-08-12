// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:card_holder/common/services/local_crud/crud_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

part '../local_crud/model/data_base_card.dart';

const _dbName = "card_hold.db";
const _cardTable = "card";
const _idColumn = "id";
const _codeColumn = "code";
const _usagePointColumn = "usage_point";
const _createCardTable = '''
      CREATE TABLE IF NOT EXISTS "card" (
      "id"	INTEGER NOT NULL,
      "code"	TEXT,
      "usage_point" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
      );''';

abstract class CardServiceAbstract {
  Future<DataBaseCard> getCard({required int id});
  Future<DataBaseCard> updateCard({
    required DataBaseCard note,
    required String text,
  });
  Future<DataBaseCard> openCard({required int index});
  Future<List<DataBaseCard>> getAllCards();
  Future<int> deleteAllCards();
  Future<void> deleteCard({required int id});
  Future<DataBaseCard> createCard({required String code});
}

class CardService implements CardServiceAbstract {
  Database? _db;

  List<DataBaseCard> _cards = [];

  static final CardService _shared = CardService._sharedInstance();
  CardService._sharedInstance();
  factory CardService() => _shared;

  final _cardsStreamController =
      StreamController<List<DataBaseCard>>.broadcast();

  Stream<List<DataBaseCard>> get allCards => _cardsStreamController.stream;

  Future<void> _cacheCards() async {
    final allCards = await getAllCards();
    _cards = allCards.toList();
    _cardsStreamController.add(_cards);
  }

  @override
  Future<DataBaseCard> updateCard({
    required DataBaseCard note,
    required String text,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    // make shure note exist
    final currentCard = await getCard(id: note.id);
    // update DB
    final updateColumn = await db.update(_cardTable, {_codeColumn: text});

    if (updateColumn == 0) {
      throw CouldNotUpdateCard();
    } else {
      _cards.removeWhere((note) => note.id == currentCard.id);
      _cards.add(currentCard);
      _cardsStreamController.add(_cards);

      return currentCard;
    }
  }

  @override
  Future<DataBaseCard> openCard({required int index}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final currentCard = await getCard(id: index);

    final updatedCard = await db.update(
      _cardTable,
      {_usagePointColumn: currentCard.usagePoint + 1},
      where: 'id = ?',
      whereArgs: [index],
    );

    if (updatedCard == 0) {
      throw CouldNotUpdateCard();
    } else {
      _cards.removeWhere((note) => note.id == currentCard.id);
      _cards.add(currentCard);
      _cardsStreamController.add(_cards);

      return currentCard;
    }
  }

  @override
  Future<List<DataBaseCard>> getAllCards() async {
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
      _cards.removeWhere((c) => c.id == id);
      _cards.add(card);
      _cardsStreamController.add(_cards);
      return card;
    }
  }

  @override
  Future<int> deleteAllCards() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final numberOfDeletions = await db.delete(_cardTable);
    _cards = [];
    _cardsStreamController.add(_cards);
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
      _cards.removeWhere((card) => card.id == id);
      _cardsStreamController.add(_cards);
    }
  }

  @override
  Future<DataBaseCard> createCard({required String code}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final cardId = await db.insert(_cardTable, {
      _codeColumn: code,
      _usagePointColumn: 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    final card = DataBaseCard(id: cardId, code: code, usagePoint: 0);

    _cards.add(card);
    _cardsStreamController.add(_cards);

    return card;
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
      /// Путь к каталогу, куда приложение может поместить данные, которые
      /// созданы пользователем, или которые не могут быть воссозданы вашим приложением.
      final docsPath = await getApplicationDocumentsDirectory();
      // укажет путь до базы данных
      final dbPath = join(docsPath.path, _dbName);
      final db = await openDatabase(
        dbPath,
        version: 1, // bump this when schema changes
        onCreate: (db, version) async {
          await db.execute(_createCardTable);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute(
              'ALTER TABLE card ADD COLUMN usage_point INTEGER DEFAULT 0',
            );
          }
        },
      );
      _db = db;

      await _cacheCards();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
