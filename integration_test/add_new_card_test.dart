import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Add new card integration test", (tester) async {
    // Start the app
    app.main();

    // Helper function for timeouts
    int timeoutSeconds = 2;
    Future<void> timeout() async =>
        await Future.delayed(Duration(seconds: timeoutSeconds));

    // Wait for app to initialize
    await tester.pumpAndSettle();
    await timeout();

    // Step 1: Find and tap the add button on home screen
    final addButtonFinder = find.text(t.screen.home.add);
    expect(addButtonFinder, findsOneWidget);

    await tester.tap(addButtonFinder);
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Step 2: Verify template selection bottom sheet opened
    // Look for Пятёрочка template (third in the list)
    final pyaterochkaFinder = find.text('Пятёрочка');
    expect(pyaterochkaFinder, findsOneWidget);
    await timeout();

    // Step 3: Tap on Пятёрочка template
    await tester.tap(pyaterochkaFinder);
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Step 4: Verify card creation bottom sheet appeared
    // Look for the manual code input field
    final codeFieldFinder = find.byWidgetPredicate(
      (widget) =>
          widget is TextField &&
          widget.decoration?.hintText == t.screen.home.addCard.code,
    );
    expect(codeFieldFinder, findsOneWidget);
    await timeout();

    // Step 5: Enter "12345" in the code text field
    await tester.enterText(codeFieldFinder, '12345');
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Verify the code was entered
    expect(find.text('12345'), findsOneWidget);
    await timeout();

    // Fill the required name field
    final nameFieldFinder = find.byWidgetPredicate(
      (widget) =>
          widget is TextField &&
          widget.decoration?.hintText == t.screen.home.addCard.name,
    );
    expect(nameFieldFinder, findsOneWidget);
    await timeout();

    await tester.enterText(nameFieldFinder, 'Test Card');
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Step 6: Find and tap the add button to create the card
    final createAddButtonFinder = find.text(t.screen.home.addCard.add);
    expect(createAddButtonFinder, findsOneWidget);
    await timeout();

    await tester.tap(createAddButtonFinder);
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Step 7: Verify we're back to home screen
    expect(find.text(t.screen.home.add), findsOneWidget);
    await timeout();
  });

  testWidgets("Template search functionality test", (tester) async {
    app.main();

    Future<void> timeout() async => await Future.delayed(Duration(seconds: 2));

    await tester.pumpAndSettle();
    await timeout();

    // Open template selection sheet
    final addButtonFinder = find.text(t.screen.home.add);
    await tester.tap(addButtonFinder);
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Test search functionality
    final searchInputFinder = find.byType(TextField).first;
    await tester.enterText(searchInputFinder, 'Пятё');
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Should still find Пятёрочка after search
    expect(find.text('Пятёрочка'), findsOneWidget);
    await timeout();

    // Clear search
    await tester.enterText(searchInputFinder, '');
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Should show multiple templates again
    expect(find.text('Пятёрочка'), findsOneWidget);
    expect(find.text('Спар'), findsOneWidget);
  });

  testWidgets("Form validation test", (tester) async {
    app.main();

    Future<void> timeout() async => await Future.delayed(Duration(seconds: 2));

    await tester.pumpAndSettle();
    await timeout();

    // Open template sheet and select Пятёрочка
    await tester.tap(find.text(t.screen.home.add));
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    await tester.tap(find.text('Пятёрочка'));
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Try to add card without filling required fields
    final createAddButtonFinder = find.text(t.screen.home.addCard.add);
    await tester.tap(createAddButtonFinder);
    await timeout();
    await tester.pumpAndSettle();
    await timeout();

    // Should show validation errors
    expect(
      find.text(t.screen.home.addCard.fieldCannotBeEmpty),
      findsAtLeastNWidgets(1),
    );
  });
}
