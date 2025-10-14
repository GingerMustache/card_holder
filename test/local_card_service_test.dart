import 'dart:io';

import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:card_holder/common/services/local_crud/exceptions/crud_exceptions.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize FFI for testing
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    const MethodChannel channel = MethodChannel(
      'plugins.flutter.io/path_provider',
    );

    // Mock path_provider
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'getApplicationDocumentsDirectory') {
            return Directory.systemTemp.path;
          }
          return null;
        });
  });

  group('LocalCardService Tests', () {
    late LocalCardService cardService;

    setUp(() async {
      cardService = LocalCardService();
      // Ensure clean state for each test
      try {
        await cardService.close();
      } catch (e) {
        // Database might not be open, ignore
      }
      await cardService.open();
      await cardService.deleteAllCards();
    });

    tearDown(() async {
      try {
        await cardService.deleteAllCards();
        await cardService.close();
      } catch (e) {
        // Ignore cleanup errors
      }
    });

    group('Database Management', () {
      test('should open database successfully', () async {
        await cardService.close();
        await cardService.open();
        // If no exception is thrown, the test passes
      });

      test(
        'should throw DatabaseIsAlreadyOpen when opening already open database',
        () async {
          // Database is already open from setUp
          expect(
            () async => await cardService.open(),
            throwsA(isA<DatabaseIsAlreadyOpen>()),
          );
        },
      );

      test('should close database successfully', () async {
        await cardService.close();
        // If no exception is thrown, the test passes
      });

      test(
        'should throw DatabaseIsNotOpen when closing already closed database',
        () async {
          await cardService.close();
          expect(
            () async => await cardService.close(),
            throwsA(isA<DatabaseIsNotOpen>()),
          );
        },
      );
    });

    group('Create Card', () {
      test('should create card successfully', () async {
        const code = '1234567890';
        const name = 'Test Card';
        const color = 0xFF2196F3;
        const urlPath = AppIcons.sparShop;

        final card = await cardService.createCard(
          code: code,
          name: name,
          color: color,
          urlPath: urlPath,
        );

        expect(card.code, equals(code));
        expect(card.name, equals(name));
        expect(card.color, equals(color));
        expect(card.usagePoint, equals(0));
        expect(card.id, isPositive);
        expect(card.urlPath, equals(urlPath));
      });

      test('should create multiple cards with different IDs', () async {
        final card1 = await cardService.createCard(
          code: '1111',
          name: 'Card 1',
          color: 0xFF000000,
          urlPath: AppIcons.fiveShop,
        );

        final card2 = await cardService.createCard(
          code: '2222',
          name: 'Card 2',
          color: 0xFFFFFFFF,
          urlPath: AppIcons.magnetShop,
        );

        expect(card1.id, isNot(equals(card2.id)));
      });

      test('should create card with empty strings', () async {
        final card = await cardService.createCard(code: '', name: '', color: 0, urlPath: '');

        expect(card.code, equals(''));
        expect(card.name, equals(''));
        expect(card.color, equals(0));
        expect(card.urlPath, equals(''));
      });

      test('should create card with urlPath', () async {
        const code = '1234567890';
        const name = 'Test Card';
        const color = 0xFF2196F3;
        const urlPath = AppIcons.dixyShop;

        final card = await cardService.createCard(
          code: code,
          name: name,
          color: color,
          urlPath: urlPath,
        );

        expect(card.code, equals(code));
        expect(card.name, equals(name));
        expect(card.color, equals(color));
        expect(card.usagePoint, equals(0));
        expect(card.id, isPositive);
        expect(card.urlPath, equals(urlPath));
      });
    });

    group('Get Card', () {
      test('should get existing card by ID', () async {
        final createdCard = await cardService.createCard(
          code: '1234567890',
          name: 'Test Card',
          color: 0xFF2196F3,
          urlPath: AppIcons.lentaShop,
        );

        final retrievedCard = await cardService.getCard(id: createdCard.id);

        expect(retrievedCard.id, equals(createdCard.id));
        expect(retrievedCard.code, equals(createdCard.code));
        expect(retrievedCard.name, equals(createdCard.name));
        expect(retrievedCard.color, equals(createdCard.color));
        expect(retrievedCard.usagePoint, equals(createdCard.usagePoint));
        expect(retrievedCard.urlPath, equals(createdCard.urlPath));
      });

      test('should throw CouldNotFindCard for non-existent ID', () async {
        expect(
          () async => await cardService.getCard(id: 999),
          throwsA(isA<CouldNotFindCard>()),
        );
      });

      test('should throw CouldNotFindCard for negative ID', () async {
        expect(
          () async => await cardService.getCard(id: -1),
          throwsA(isA<CouldNotFindCard>()),
        );
      });
    });

    group('Get All Cards', () {
      test('should return empty list when no cards exist', () async {
        final cards = await cardService.getCards();
        expect(cards, isEmpty);
      });

      test('should return all created cards', () async {
        await cardService.createCard(code: '1111', name: 'Card 1', color: 1, urlPath: AppIcons.fiveShop);
        await cardService.createCard(code: '2222', name: 'Card 2', color: 2, urlPath: AppIcons.ashanShop);
        await cardService.createCard(code: '3333', name: 'Card 3', color: 3, urlPath: AppIcons.dixyShop);

        final cards = await cardService.getCards();
        expect(cards.length, equals(3));
      });

      test('should return cards sorted by usage point descending', () async {
        final card1 = await cardService.createCard(
          code: '1111',
          name: 'Card 1',
          color: 1,
          urlPath: AppIcons.fiveShop,
        );
        final card2 = await cardService.createCard(
          code: '2222',
          name: 'Card 2',
          color: 2,
          urlPath: AppIcons.ashanShop,
        );
        final card3 = await cardService.createCard(
          code: '3333',
          name: 'Card 3',
          color: 3,
          urlPath: AppIcons.dixyShop,
        );

        // Open cards to increase usage points
        await cardService.openCard(id: card2.id); // card2 usage: 1
        await cardService.openCard(id: card3.id); // card3 usage: 1
        await cardService.openCard(id: card3.id); // card3 usage: 2

        final cards = await cardService.getCards();

        // Should be sorted: card3 (usage: 2), card2 (usage: 1), card1 (usage: 0)
        expect(cards[0].id, equals(card3.id));
        expect(cards[1].id, equals(card2.id));
        expect(cards[2].id, equals(card1.id));
      });
    });

    group('Update Card', () {
      test('should update existing card successfully', () async {
        final originalCard = await cardService.createCard(
          code: '1234567890',
          name: 'Original Card',
          color: 0xFF000000,
          urlPath: AppIcons.ashanShop,
        );

        const newCode = '0987654321';
        const newName = 'Updated Card';
        const newColor = 0xFFFFFFFF;
        const newUrlPath = AppIcons.metroShop;

        final returnedCard = await cardService.updateCard(
          id: originalCard.id,
          code: newCode,
          name: newName,
          color: newColor,
          urlPath: newUrlPath,
        );

        // The method returns the card before update
        expect(returnedCard.code, equals(originalCard.code));
        expect(returnedCard.name, equals(originalCard.name));
        expect(returnedCard.color, equals(originalCard.color));
        expect(returnedCard.urlPath, equals(originalCard.urlPath));

        // Verify the card was actually updated
        final updatedCard = await cardService.getCard(id: originalCard.id);
        expect(updatedCard.code, equals(newCode));
        expect(updatedCard.name, equals(newName));
        expect(updatedCard.color, equals(newColor));
        expect(updatedCard.urlPath, equals(newUrlPath));
        expect(
          updatedCard.usagePoint,
          equals(originalCard.usagePoint),
        ); // Should remain unchanged
      });

      test('should throw CouldNotUpdateCard for non-existent ID', () async {
        expect(
          () async => await cardService.updateCard(
            id: 999,
            code: 'test',
            name: 'test',
            color: 0,
            urlPath: AppIcons.okShop,
          ),
          throwsA(
            isA<CouldNotFindCard>(),
          ), // This will be thrown by getCard first
        );
      });

      test('should update card with empty values', () async {
        final originalCard = await cardService.createCard(
          code: '1234567890',
          name: 'Original Card',
          color: 0xFF000000,
          urlPath: AppIcons.sportmasterShop,
        );

        await cardService.updateCard(
          id: originalCard.id,
          code: '',
          name: '',
          color: 0,
          urlPath: '',
        );

        final updatedCard = await cardService.getCard(id: originalCard.id);
        expect(updatedCard.code, equals(''));
        expect(updatedCard.name, equals(''));
        expect(updatedCard.color, equals(0));
        expect(updatedCard.urlPath, equals(''));
      });
    });

    group('Open Card', () {
      test('should increment usage point when opening card', () async {
        final card = await cardService.createCard(
          code: '1234567890',
          name: 'Test Card',
          color: 0xFF2196F3,
          urlPath: AppIcons.vkusVilShop,
        );

        expect(card.usagePoint, equals(0));

        await cardService.openCard(id: card.id);

        final updatedCard = await cardService.getCard(id: card.id);
        expect(updatedCard.usagePoint, equals(1));
      });

      test('should increment usage point multiple times', () async {
        final card = await cardService.createCard(
          code: '1234567890',
          name: 'Test Card',
          color: 0xFF2196F3,
          urlPath: AppIcons.perectrestokShop,
        );

        await cardService.openCard(id: card.id);
        await cardService.openCard(id: card.id);
        await cardService.openCard(id: card.id);

        final updatedCard = await cardService.getCard(id: card.id);
        expect(updatedCard.usagePoint, equals(3));
      });

      test('should return card before usage point increment', () async {
        final card = await cardService.createCard(
          code: '1234567890',
          name: 'Test Card',
          color: 0xFF2196F3,
          urlPath: AppIcons.kbShop,
        );

        final returnedCard = await cardService.openCard(id: card.id);

        // Should return the card with original usage point
        expect(returnedCard.usagePoint, equals(0));

        // But the actual card should be updated
        final updatedCard = await cardService.getCard(id: card.id);
        expect(updatedCard.usagePoint, equals(1));
      });

      test('should throw CouldNotFindCard for non-existent ID', () async {
        expect(
          () async => await cardService.openCard(id: 999),
          throwsA(isA<CouldNotFindCard>()),
        );
      });
    });

    group('Delete Card', () {
      test('should delete existing card successfully', () async {
        final card = await cardService.createCard(
          code: '1234567890',
          name: 'Test Card',
          color: 0xFF2196F3,
          urlPath: AppIcons.sparShop,
        );

        await cardService.deleteCard(id: card.id);

        expect(
          () async => await cardService.getCard(id: card.id),
          throwsA(isA<CouldNotFindCard>()),
        );
      });

      test('should throw CouldNotDeleteCard for non-existent ID', () async {
        expect(
          () async => await cardService.deleteCard(id: 999),
          throwsA(isA<CouldNotDeleteCard>()),
        );
      });

      test('should not affect other cards when deleting one', () async {
        final card1 = await cardService.createCard(
          code: '1111',
          name: 'Card 1',
          color: 1,
          urlPath: AppIcons.fiveShop,
        );
        final card2 = await cardService.createCard(
          code: '2222',
          name: 'Card 2',
          color: 2,
          urlPath: AppIcons.magnetShop,
        );

        await cardService.deleteCard(id: card1.id);

        // card2 should still exist
        final remainingCard = await cardService.getCard(id: card2.id);
        expect(remainingCard.id, equals(card2.id));

        // card1 should be gone
        expect(
          () async => await cardService.getCard(id: card1.id),
          throwsA(isA<CouldNotFindCard>()),
        );
      });
    });

    group('Delete All Cards', () {
      test('should return 0 when deleting from empty database', () async {
        final deletedCount = await cardService.deleteAllCards();
        expect(deletedCount, equals(0));
      });

      test('should delete all cards and return correct count', () async {
        await cardService.createCard(code: '1111', name: 'Card 1', color: 1, urlPath: AppIcons.dixyShop);
        await cardService.createCard(code: '2222', name: 'Card 2', color: 2, urlPath: AppIcons.ashanShop);
        await cardService.createCard(code: '3333', name: 'Card 3', color: 3, urlPath: AppIcons.lentaShop);

        final deletedCount = await cardService.deleteAllCards();
        expect(deletedCount, equals(3));

        final remainingCards = await cardService.getCards();
        expect(remainingCards, isEmpty);
      });

      test('should handle multiple delete all operations', () async {
        await cardService.createCard(code: '1111', name: 'Card 1', color: 1, urlPath: AppIcons.fiveShop);

        final firstDelete = await cardService.deleteAllCards();
        expect(firstDelete, equals(1));

        final secondDelete = await cardService.deleteAllCards();
        expect(secondDelete, equals(0));
      });
    });

    group('Database State Management', () {
      test('should handle operations when database is not open', () async {
        await cardService.close();

        // Operations should automatically open the database
        final card = await cardService.createCard(
          code: '1234567890',
          name: 'Test Card',
          color: 0xFF2196F3,
          urlPath: AppIcons.sparShop,
        );

        expect(card.id, isPositive);
      });

      test('should maintain data consistency across operations', () async {
        final card = await cardService.createCard(
          code: '1234567890',
          name: 'Test Card',
          color: 0xFF2196F3,
          urlPath: AppIcons.fiveShop,
        );

        await cardService.openCard(id: card.id);
        await cardService.updateCard(
          id: card.id,
          code: 'updated',
          name: 'Updated',
          color: 0xFFFF0000,
          urlPath: AppIcons.magnetShop,
        );

        final finalCard = await cardService.getCard(id: card.id);
        expect(finalCard.code, equals('updated'));
        expect(finalCard.name, equals('Updated'));
        expect(finalCard.color, equals(0xFFFF0000));
        expect(finalCard.urlPath, equals(AppIcons.magnetShop));
        expect(finalCard.usagePoint, equals(1)); // Should preserve usage point
      });
    });

    group('Edge Cases', () {
      test('should handle very long strings', () async {
        final longString = 'a' * 1000;

        final card = await cardService.createCard(
          code: longString,
          name: longString,
          color: 0xFF2196F3,
          urlPath: longString,
        );

        expect(card.code, equals(longString));
        expect(card.name, equals(longString));
        expect(card.urlPath, equals(longString));
      });

      test('should handle special characters in strings', () async {
        const specialCode = "!@#\$%^&*()_+-=[]{}|;':\",./<>?";
        const specialName = "Card with émojis 🎉 and ñ characters";
        const specialUrl = "!@#\$%^&*()_+-=[]{}|;':\",./<>?";

        final card = await cardService.createCard(
          code: specialCode,
          name: specialName,
          color: 0xFF2196F3,
          urlPath: specialUrl,
        );

        expect(card.code, equals(specialCode));
        expect(card.name, equals(specialName));
        expect(card.urlPath, equals(specialUrl));
      });

      test('should handle maximum and minimum color values', () async {
        final maxColorCard = await cardService.createCard(
          code: 'max',
          name: 'Max Color',
          color: 0xFFFFFFFF,
          urlPath: AppIcons.sparShop,
        );

        final minColorCard = await cardService.createCard(
          code: 'min',
          name: 'Min Color',
          color: 0x00000000,
          urlPath: AppIcons.dixyShop,
        );

        expect(maxColorCard.color, equals(0xFFFFFFFF));
        expect(minColorCard.color, equals(0x00000000));
      });

      test('should handle rapid sequential operations', () async {
        final futures = <Future<DataBaseCard>>[];

        // Create multiple cards simultaneously
        for (int i = 0; i < 10; i++) {
          futures.add(
            cardService.createCard(code: 'code$i', name: 'Card $i', color: i, urlPath: 'url$i'),
          );
        }

        final cards = await Future.wait(futures);
        expect(cards.length, equals(10));

        // Verify all cards have unique IDs
        final ids = cards.map((c) => c.id).toSet();
        expect(ids.length, equals(10));
      });
    });
  });
}
