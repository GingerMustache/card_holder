// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:card_holder/common/services/local_crud/crud_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CardService {
  Database? _db;

  List<DataBaseCards> _cards = [];

  static final CardService _shared = CardService._sharedInstance();
  CardService._sharedInstance();
  factory CardService() => _shared;

  final _cardsStreamController =
      StreamController<List<DataBaseCards>>.broadcast();

  Stream<List<DataBaseCards>> get allCards => _cardsStreamController.stream;

  Future<void> _cacheCards() async {
    final allCards = await getAllCards();
    _cards = allCards.toList();
    _cardsStreamController.add(_cards);
  }

  Future<DataBaseCards> updateCard({
    required DataBaseCards note,
    required String text,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    // make shure note exist
    await getCard(id: note.id);
    // update DB
    final updateColumn = await db.update(cardTable, {textColumn: text});

    if (updateColumn == 0) {
      throw CouldNotUpdateNote();
    } else {
      final updateNotes = await getCard(id: note.id);
      _cards.removeWhere((note) => note.id == updateNotes.id);
      _cards.add(updateNotes);
      _cardsStreamController.add(_cards);

      return updateNotes;
    }
  }

  Future<Iterable<DataBaseCards>> getAllCards() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(cardTable);

    return notes.map((noteRow) => DataBaseCards.fromRow(noteRow));
  }

  Future<DataBaseCards> getCard({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final notes = await db.query(
      cardTable, // где в базе искать
      limit: 1, // сколько
      where: "id = ?", // где в колонке noteTable искать
      whereArgs: [id], // аргумент поиска
    );

    if (notes.isEmpty) {
      throw CouldNotFindNote();
    } else {
      final note = DataBaseCards.fromRow(notes.first);
      _cards.removeWhere((note) => note.id == id);
      _cards.add(note);
      _cardsStreamController.add(_cards);
      return note;
    }
  }

  Future<int> deleteAllCards() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final numberOfDeletions = await db.delete(cardTable);
    _cards = [];
    _cardsStreamController.add(_cards);
    return numberOfDeletions;
    // what happened in case of empty notes list?
  }

  Future<void> deleteCard({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final deletedCount = await db.delete(
      cardTable,
      where: "id = ?",
      whereArgs: [id],
    );
    if (deletedCount == 0) {
      throw CouldNotDeleteNote();
    } else {
      // .removeWhere удаляет в листе 'типа', те значения, которые соответсвуют условию
      // в данном случае, в DataBaseNote есть id'шник, который мы получим в параметры функции
      // и по нему мы удалим заметку
      _cards.removeWhere((note) => note.id == id);
      _cardsStreamController.add(_cards);
    }
  }

  Future<DataBaseCards> createCard({required String code}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final cardId = await db.insert(cardTable, {
      codeColumn: code,
      usagePointColumn: 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    final card = DataBaseCards(id: cardId, code: code, usagePoint: 0);

    _cards.add(card);
    _cardsStreamController.add(_cards);

    return card;
  }

  Future<DataBaseUser> getUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    // кидаем запрос на пользователя
    // в поле email
    final result = await db.query(
      userTable,
      limit: 1,
      where: "email = ?",
      whereArgs: [email.toLowerCase()],
    );
    if (result.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DataBaseUser.fromRow(result.first);
    }
  }

  Future<DataBaseUser> createUser({required String email}) async {
    await _ensureDbIsOpen();
    // проверяем наличие email в базе данных
    final db = _getDatabaseOrThrow();

    final result = await db.query(
      userTable,
      limit: 1,
      where: "email = ?",
      whereArgs: [email.toLowerCase()],
    );
    // если да, кидаем ошибку
    if (result.isNotEmpty) {
      throw UserAlreadyExists();
    }
    // нет, добавляем в базу и возвращяем в userId, id'шник последней строки
    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });
    return DataBaseUser(id: userId, email: email);
  }

  Future<void> deleteUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: "email = ?",
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) {
      throw CouldNotDeleteUser();
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
    if (_db != null) {
      throw DatabaseIsAlreadyOpen();
    }
    try {
      /// Путь к каталогу, куда приложение может поместить данные, которые
      /// созданы пользователем, или которые не могут быть воссозданы вашим приложением.
      final docsPath = await getApplicationDocumentsDirectory();
      // укажет путь до базы данных
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(
        dbPath,
        version: 1, // bump this when schema changes
        onCreate: (db, version) async {
          await db.execute(createCardTable);
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
      // create note table
      // await db.execute(createCardTable);
      // state streamController of notes
      await _cacheCards();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}

@immutable
class DataBaseUser {
  final int id;
  final String email;

  const DataBaseUser({required this.id, required this.email});

  // именнованый конструктор передающий в поля класса значение мапы по ключу
  DataBaseUser.fromRow(Map<String, Object?> map)
    : id = map[idColumn] as int,
      email = map[emailColumn] as String;

  @override
  String toString() => "Person, ID = $id, email = $email";

  @override
  bool operator ==(covariant DataBaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DataBaseCards extends Equatable {
  final int id;
  final String code;
  final int usagePoint;

  DataBaseCards({
    required this.id,
    required this.code,
    required this.usagePoint,
  });

  DataBaseCards.fromRow(Map<String, Object?> map)
    : id = map[idColumn] as int,
      usagePoint = map[idColumn] as int,
      code = map[textColumn] as String;

  @override
  String toString() => "Note, ID = $id, code = $code, usagePoint = $usagePoint";

  @override
  List<Object?> get props => [id, code, usagePoint];
}

const dbName = "card_hold.db";
const cardTable = "card";
const codeColumn = "code";
const usagePointColumn = "usage_point";
const userTable = "user";
const idColumn = "id";
const emailColumn = "email";
const userIdColumn = "user_id";
const textColumn = "text";
const createUserTable = ''' 
      CREATE TABLE IF NOT EXISTS  "user" (
	    "id"	INTEGER NOT NULL,
	    "email"	TEXT NOT NULL UNIQUE,
	    PRIMARY KEY("id" AUTOINCREMENT)
      );''';
const createCardTable = '''
      CREATE TABLE IF NOT EXISTS "card" (
      "id"	INTEGER NOT NULL,
      "code"	TEXT,
      "usage_point" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
      );''';
