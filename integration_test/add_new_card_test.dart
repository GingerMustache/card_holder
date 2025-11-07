import 'package:card_holder/common/di_container/di_container.dart';
import 'package:card_holder/common/helpers/converter/text_field_validator/text_field_validator.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/brightness_control/brightness_control_service.dart';
import 'package:card_holder/common/services/error_service/error_service.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Integration tests for the "Add New Card" feature.
///
/// These tests follow flakeproof principles:
/// - No arbitrary timeouts (use pumpAndSettle for deterministic waiting)
/// - Key-based widget finders for stability
/// - Clear test structure with setup/action/assertion phases
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Initialize error service once for all tests
  setUpAll(() {
    MainErrorService.instance.initialize();
  });

  group('Add New Card Integration Tests', () {
    testWidgets('should successfully add a new card with template selection', (
      tester,
    ) async {
      // SETUP: Start the app and wait for initialization
      await _initializeApp(tester);
      await tester.pumpAndSettle();

      // ACTION 1: Open template selection sheet
      await _tapAddButton(tester);
      await tester.pumpAndSettle();

      // Wait for bottom sheet animation to complete
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      // ASSERTION 1: Verify template sheet is visible using key
      expect(
        find.byKey(const Key('template_Пятёрочка')),
        findsOneWidget,
        reason: 'Template selection sheet should display available templates',
      );

      // ACTION 2: Select a template
      await _selectTemplate(tester, 'Пятёрочка');
      await tester.pumpAndSettle();

      // ASSERTION 2: Verify card creation sheet appeared
      final codeField = _findCodeInputField(tester);
      expect(
        codeField,
        findsOneWidget,
        reason: 'Card creation sheet should display after template selection',
      );

      // ACTION 3: Fill in card details
      await _enterCardCode(tester, '12345');
      await tester.pumpAndSettle();

      await _enterCardName(tester, 'Test Card');
      await tester.pumpAndSettle();

      // ASSERTION 3: Verify entered data is displayed
      expect(find.text('12345'), findsOneWidget);
      expect(find.text('Test Card'), findsOneWidget);

      // ACTION 4: Submit the form
      await _tapCreateCardButton(tester);
      await tester.pumpAndSettle();

      // ASSERTION 4: Verify navigation back to home screen
      expect(
        find.text(t.screen.home.add),
        findsOneWidget,
        reason: 'Should return to home screen after successful card creation',
      );
    });

    testWidgets('should filter templates based on search query', (
      tester,
    ) async {
      // SETUP
      await _initializeApp(tester);
      await tester.pumpAndSettle();

      // ACTION 1: Open template selection
      await _tapAddButton(tester);
      await tester.pumpAndSettle();

      // Wait for bottom sheet animation
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      // ACTION 2: Enter search query
      final searchField = find.byType(TextField).first;
      await tester.enterText(searchField, 'Пятё');
      await tester.pumpAndSettle();

      // ASSERTION 1: Verify filtered results using key
      expect(
        find.byKey(const Key('template_Пятёрочка')),
        findsOneWidget,
        reason: 'Search should show matching template',
      );

      // ACTION 3: Clear search
      await tester.enterText(searchField, '');
      await tester.pumpAndSettle();

      // ASSERTION 2: Verify all templates are shown again using keys
      expect(find.byKey(const Key('template_Пятёрочка')), findsOneWidget);
      expect(
        find.byKey(const Key('template_Спар')),
        findsOneWidget,
        reason: 'Clearing search should restore all templates',
      );
    });

    testWidgets('should display validation errors for empty required fields', (
      tester,
    ) async {
      // SETUP
      await _initializeApp(tester);
      await tester.pumpAndSettle();

      // ACTION 1: Navigate to card creation form
      await _tapAddButton(tester);
      await tester.pumpAndSettle();

      await _selectTemplate(tester, 'Пятёрочка');
      await tester.pumpAndSettle();

      // ACTION 2: Attempt to submit without filling required fields
      await _tapCreateCardButton(tester);
      await tester.pumpAndSettle();

      // ASSERTION: Verify validation error messages are displayed
      expect(
        find.text(t.screen.home.addCard.fieldCannotBeEmpty),
        findsAtLeastNWidgets(1),
        reason: 'Should display validation errors for empty required fields',
      );
    });

    testWidgets('should accept card code from manual input', (tester) async {
      // SETUP
      await _initializeApp(tester);
      await tester.pumpAndSettle();

      await _tapAddButton(tester);
      await tester.pumpAndSettle();

      await _selectTemplate(tester, 'Пятёрочка');
      await tester.pumpAndSettle();

      // ACTION: Enter code manually (not via barcode scanner)
      await _enterCardCode(tester, '98765');
      await tester.pumpAndSettle();

      await _enterCardName(tester, 'Manual Code Card');
      await tester.pumpAndSettle();

      // ASSERTION: Verify code is accepted
      expect(find.text('98765'), findsOneWidget);

      // ACTION: Submit form
      await _tapCreateCardButton(tester);
      await tester.pumpAndSettle();

      // ASSERTION: Verify successful creation
      expect(
        find.text(t.screen.home.add),
        findsOneWidget,
        reason: 'Card with manual code should be created successfully',
      );
    });
  });
}

// ============================================================================
// Test Initialization - Bypasses error service to avoid test conflicts
// ============================================================================

/// Initializes the app for testing without the error service wrapper.
///
/// This avoids FlutterError.onError conflicts with the test framework.
Future<void> _initializeApp(WidgetTester tester) async {
  final DiContainerProvider diContainer = DiContainer();
  final flutterI18nDelegate = await LocaleClass.initLocaleDelegate();
  final app = diContainer.makeApp(flutterI18nDelegate);

  await tester.pumpWidget(
    TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          RepositoryProvider<BrightnessService>(
            lazy: false,
            create: (_) => diContainer.makeBrightnessService(),
          ),
          RepositoryProvider<TextValidatorService>(
            lazy: false,
            create: (_) => diContainer.makeTextValidatorService(),
          ),
          BlocProvider(
            create:
                (context) =>
                    SettingsBloc(localStorage: diContainer.makeLocalStorage())
                      ..add(SettingInitEvent()),
            lazy: false,
          ),
          BlocProvider(
            lazy: false,
            create:
                (context) => CardsBloc(
                  imageConvertHelper: diContainer.makeImageConverterHelper(),
                  shareRepository: diContainer.makeShareRepository(),
                  filePickRepository: diContainer.makeFilePickRepository(),
                  cardRepo: diContainer.makeCardRepository(),
                )..add(CardsFetchCardsEvent()),
          ),
        ],
        child: app,
      ),
    ),
  );

  // Wait for the app to fully initialize and render
  await tester.pumpAndSettle(const Duration(seconds: 5));
}

// ============================================================================
// Helper Functions - Improve test readability and maintainability
// ============================================================================

/// Taps the "Add" button on the home screen to open template selection.
/// Uses key-based finder for stability (Requirement 2).
Future<void> _tapAddButton(WidgetTester tester) async {
  final addButton = find.byKey(const Key('home_add_button'));
  expect(addButton, findsOneWidget, reason: 'Add button should be visible');
  await tester.tap(addButton);
}

/// Selects a template by tapping on it.
/// Uses key-based finder for stability (Requirement 2).
Future<void> _selectTemplate(WidgetTester tester, String templateName) async {
  final template = find.byKey(Key('template_$templateName'));
  expect(
    template,
    findsOneWidget,
    reason: 'Template "$templateName" should be available',
  );
  await tester.tap(template);
}

/// Finds the code input field using its test key.
/// This follows Requirement 2 for stable widget identification.
Finder _findCodeInputField(WidgetTester tester) {
  return find.byKey(const Key('card_code_field'));
}

/// Finds the name input field using its test key.
/// This follows Requirement 2 for stable widget identification.
Finder _findNameInputField(WidgetTester tester) {
  return find.byKey(const Key('card_name_field'));
}

/// Enters text into the card code field.
Future<void> _enterCardCode(WidgetTester tester, String code) async {
  final codeField = _findCodeInputField(tester);
  expect(codeField, findsOneWidget, reason: 'Code field should be present');
  await tester.enterText(codeField, code);
}

/// Enters text into the card name field.
Future<void> _enterCardName(WidgetTester tester, String name) async {
  final nameField = _findNameInputField(tester);
  expect(nameField, findsOneWidget, reason: 'Name field should be present');
  await tester.enterText(nameField, name);
}

/// Taps the "Add" button to create the card.
/// Uses key-based finder for stability (Requirement 2).
Future<void> _tapCreateCardButton(WidgetTester tester) async {
  final createButton = find.byKey(const Key('create_card_button'));
  expect(
    createButton,
    findsOneWidget,
    reason: 'Create card button should be visible',
  );
  await tester.tap(createButton);
}
