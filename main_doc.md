# Card Holder App Documentation

## Overview
Card Holder is a Flutter application designed for securely managing and storing various card information locally. It provides a user-friendly interface for adding, viewing, and organizing cards, with a focus on local data persistence and efficient access.

## Project Structure

The project follows a standard Flutter application structure with additional organization for features and common utilities.

-   **`.fvm/`**: Flutter Version Management configuration.
-   **`.git/`**: Git version control system files.
-   **`.idea/`**: IntelliJ IDEA/Android Studio project files.
-   **`.vscode/`**: VS Code editor configuration.
-   **`android/`**: Android-specific project files.
-   **`assets/`**: Contains application assets like fonts and SVG icons.
    -   **`assets/fonts/`**: Custom fonts used in the application (Chakra Petch, Densmore, Tektur).
    -   **`assets/icons/`**: SVG icons for various functionalities (barcode, bookmark, lens, search).
    -   **`assets/icons/shops/`**: SVG icons for different shop logos.
-   **`build/`**: Generated build artifacts.
-   **`ios/`**: iOS-specific project files.
-   **`lib/`**: The main application source code.
    -   **`lib/main.dart`**: The application's entry point.
    -   **`lib/common/`**: Contains shared components, utilities, and application-wide configurations.
        -   **`lib/common/application/`**: Application-level settings, styles (colors, text styles, box shadows, button styles, paddings), and links.
        -   **`lib/common/constants/`**: Application constants.
        -   **`lib/common/data/`**: Common data models or services.
        -   **`lib/common/di_container/`**: Dependency Injection setup.
        -   **`lib/common/extensions/`**: Dart extension methods.
        -   **`lib/common/helpers/`**: Helper functions.
        -   **`lib/common/localization/`**: Internationalization and localization files.
        -   **`lib/common/mixins/`**: Reusable mixins.
        -   **`lib/common/presentation/`**: Common UI widgets or presentation logic.
        -   **`lib/common/repositories/`**: Abstract repository interfaces.
        -   **`lib/common/routing/`**: Application routing configuration.
        -   **`lib/common/services/`**: Common services (e.g., `LocalCardService`).
        -   **`lib/common/sheets/`**: Bottom sheets or modal components.
        -   **`lib/common/typography/`**: Typography definitions.
    -   **`lib/features/`**: Contains feature-specific modules, each encapsulating its own UI, logic, and data.
        -   **`lib/features/add_new_card/`**: Functionality for adding new cards.
        -   **`lib/features/home/`**: The main home screen and related components.
        -   **`lib/features/open_card/`**: Functionality for viewing and interacting with an opened card.
        -   **`lib/features/settings/`**: Application settings and configurations.
-   **`test/`**: Unit and widget tests for the application.
-   **`windows/`**: Windows-specific project files.

## Configuration Files

-   **`.env`**: Environment variables.
-   **`.fvmrc`**: FVM (Flutter Version Management) configuration file.
-   **`.gitignore`**: Specifies intentionally untracked files to ignore.
-   **`.metadata`**: Flutter project metadata.
-   **`analysis_options.yaml`**: Dart static analysis options and lint rules.
-   **`devtools_options.yaml`**: Dart DevTools configuration.
-   **`flutter_launcher_icons.yaml`**: Configuration for generating app launcher icons.
-   **`pubspec.lock`**: Records the specific versions of dependencies used.
-   **`pubspec.yaml`**: Project dependencies, metadata, and asset declarations.
-   **`README.md`**: Project README file.
-   **`slang.yaml`**: Configuration for the `slang` internationalization tool.

## Architecture

### Local Card Service (`LocalCardService`)

The `LocalCardService` class provides CRUD operations for managing cards in a local SQLite database. It implements the singleton pattern and follows the repository pattern through the `CardServiceAbstract` interface.

#### Database Schema

**Table: `card`**
- `id` (INTEGER, PRIMARY KEY, AUTOINCREMENT) - Unique identifier
- `code` (TEXT) - Card code/number
- `name` (TEXT) - Card display name
- `color` (INTEGER) - Card color representation
- `usage_point` (INTEGER) - Usage counter for tracking card access frequency

#### Core Features

1.  **Card Management**: Create, read, update, and delete cards
2.  **Usage Tracking**: Automatic usage point increment when cards are opened
3.  **Sorting**: Cards are retrieved sorted by usage frequency (most used first)
4.  **Database Management**: Automatic database initialization and migration support

## LocalCardService API Reference

### Public Methods

#### `createCard({required String code, required String name, required int color})`
Creates a new card in the database.

**Parameters:**
- `code` (String): The card code/number
- `name` (String): Display name for the card
- `color` (int): Color representation as integer

**Returns:** `Future<DataBaseCard>` - The created card with assigned ID

**Throws:**
- Database-related exceptions if creation fails

---

#### `getCard({required int id})`
Retrieves a specific card by its ID.

**Parameters:**
- `id` (int): The card's unique identifier

**Returns:** `Future<DataBaseCard>` - The requested card

**Throws:**
- `CouldNotFindCard` - If no card exists with the given ID

---

#### `getCards()`
Retrieves all cards from the database, ordered by usage frequency.

**Returns:** `Future<List<DataBaseCard>>` - List of all cards sorted by usage_point (descending)

---

#### `updateCard({required int id, required String code, required String name, required int color})`
Updates an existing card's information.

**Parameters:**
- `id` (int): The card's unique identifier
- `code` (String): New card code/number
- `name` (String): New display name
- `color` (int): New color representation

**Returns:** `Future<DataBaseCard>` - The card before update

**Throws:**
- `CouldNotUpdateCard` - If update operation fails
- `CouldNotFindCard` - If card doesn't exist

---

#### `openCard({required int id})`
Opens a card and increments its usage counter.

**Parameters:**
- `id` (int): The card's unique identifier

**Returns:** `Future<DataBaseCard>` - The card before usage point increment

**Throws:**
- `CouldNotOpenCard` - If usage point update fails
- `CouldNotFindCard` - If card doesn't exist

---

#### `deleteCard({required int id})`
Deletes a specific card from the database.

**Parameters:**
- `id` (int): The card's unique identifier

**Returns:** `Future<void>`

**Throws:**
- `CouldNotDeleteCard` - If deletion fails (card doesn't exist)

---

#### `deleteAllCards()`
Removes all cards from the database.

**Returns:** `Future<int>` - Number of deleted cards

---

### Database Management Methods

#### `open()`
Opens the database connection and creates tables if needed.

**Throws:**
- `DatabaseIsAlreadyOpen` - If database is already open
- `UnableToGetDocumentsDirectory` - If can't access app documents directory

---

#### `close()`
Closes the database connection.

**Throws:**
- `DatabaseIsNotOpen` - If database is not currently open

---

## DataBaseCard Model

The `DataBaseCard` class represents a card entity with the following properties:

```dart
class DataBaseCard extends Equatable {
  final int id;           // Unique identifier
  final String code;      // Card code/number
  final String name;      // Display name
  final int color;        // Color representation
  final int usagePoint;   // Usage frequency counter
}
```

### Methods:
- `fromRow(Map<String, Object?> map)` - Creates instance from database row
- `copyWith({...})` - Creates a copy with modified properties
- `toString()` - String representation for debugging

## Exception Handling

The service uses custom exceptions for error handling:

- `DatabaseIsAlreadyOpen` - Database connection already exists
- `DatabaseIsNotOpen` - No active database connection
- `UnableToGetDocumentsDirectory` - Can't access app storage
- `CouldNotFindCard` - Card not found in database
- `CouldNotDeleteCard` - Card deletion failed
- `CouldNotUpdateCard` - Card update failed
- `CouldNotOpenCard` - Usage point update failed

## Usage Examples

```dart
final cardService = LocalCardService();

// Create a new card
final newCard = await cardService.createCard(
  code: "1234567890",
  name: "My Credit Card",
  color: 0xFF2196F3,
);

// Get all cards
final allCards = await cardService.getCards();

// Open a card (increments usage)
await cardService.openCard(id: newCard.id);

// Update card information
await cardService.updateCard(
  id: newCard.id,
  code: "0987654321",
  name: "Updated Card Name",
  color: 0xFFFF5722,
);

// Delete a card
await cardService.deleteCard(id: newCard.id);
```

## Testing

Comprehensive test coverage is provided in `/test/local_card_service_test.dart` covering:
- All CRUD operations
- Error scenarios and exception handling
- Database state management
- Usage point tracking functionality
- Edge cases and boundary conditions

## Database Migration

The service supports database versioning and migration:
- Version 1: Initial card table creation
- Version 2: Added db_meta table for metadata tracking

Future migrations can be added in the `onUpgrade` callback of the database initialization.

## Running Tests

To run the comprehensive test suite for the LocalCardService:

```bash
# Run all tests
flutter test

# Run only the LocalCardService tests
flutter test test/local_card_service_test.dart

# Run tests with coverage
flutter test --coverage
```

### Test Coverage

The test suite includes 32 comprehensive tests covering:

-   **Database Management** (4 tests): Opening, closing, and connection state management
-   **Create Card** (3 tests): Card creation with various inputs and edge cases
-   **Get Card** (3 tests): Retrieving cards by ID and error handling
-   **Get All Cards** (3 tests): Listing cards and sorting functionality
-   **Update Card** (3 tests): Modifying existing cards and validation
-   **Open Card** (4 tests): Usage tracking and increment functionality
-   **Delete Card** (3 tests): Single card deletion and error scenarios
-   **Delete All Cards** (3 tests): Bulk deletion operations
-   **Database State Management** (2 tests): Connection handling and data consistency
-   **Edge Cases** (4 tests): Special characters, long strings, extreme values, and concurrent operations

All tests use an in-memory SQLite database with mocked file system access for fast, isolated testing.

## Development Notes

### Code Quality
- The service follows SOLID principles with clear separation of concerns
- Implements proper error handling with custom exceptions
- Uses the singleton pattern for database connection management
- Includes comprehensive logging and debugging support

### Performance Considerations
- Database operations are optimized with proper indexing
- Usage-based sorting improves user experience for frequently accessed cards
- Connection pooling through singleton pattern reduces overhead
- Automatic database migration support for future schema changes

### Security
- Input validation prevents SQL injection attacks
- Proper error handling prevents information leakage
- Local storage ensures data privacy and offline functionality
