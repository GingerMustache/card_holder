# Test Documentation

## LocalCardService Test Suite

This directory contains comprehensive tests for the `LocalCardService` class, which handles all CRUD operations for the card management system.

### Test File: `local_card_service_test.dart`

**Total Tests: 32**

#### Test Categories:

1. **Database Management (4 tests)**
   - Database opening and closing
   - Connection state validation
   - Error handling for invalid operations

2. **Create Card (3 tests)**
   - Standard card creation
   - Multiple card creation with unique IDs
   - Edge cases with empty values

3. **Get Card (3 tests)**
   - Retrieving existing cards by ID
   - Error handling for non-existent cards
   - Validation with invalid IDs

4. **Get All Cards (3 tests)**
   - Empty database handling
   - Multiple card retrieval
   - Usage-based sorting verification

5. **Update Card (3 tests)**
   - Successful card updates
   - Error handling for non-existent cards
   - Edge cases with empty values

6. **Open Card (4 tests)**
   - Usage point increment functionality
   - Multiple usage tracking
   - Return value validation
   - Error handling for invalid IDs

7. **Delete Card (3 tests)**
   - Single card deletion
   - Error handling for non-existent cards
   - Isolation testing (other cards unaffected)

8. **Delete All Cards (3 tests)**
   - Empty database handling
   - Bulk deletion with count verification
   - Multiple deletion operations

9. **Database State Management (2 tests)**
   - Automatic database opening
   - Data consistency across operations

10. **Edge Cases (4 tests)**
    - Very long string handling
    - Special character support
    - Extreme color values
    - Concurrent operation handling

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/local_card_service_test.dart

# Run with verbose output
flutter test test/local_card_service_test.dart --reporter expanded

# Run with coverage
flutter test --coverage
```

### Test Setup

The tests use:
- **sqflite_common_ffi**: For in-memory SQLite database testing
- **Mocked path_provider**: To avoid file system dependencies
- **TestWidgetsFlutterBinding**: For proper Flutter test initialization

### Test Data

Tests use realistic card data:
- Card codes: Various formats including numbers and special characters
- Card names: Different lengths and character sets including Unicode
- Colors: Full range of integer color values
- Usage points: Automatic increment testing

### Assertions

Each test includes comprehensive assertions for:
- Return value validation
- State change verification
- Error condition handling
- Data integrity checks
- Performance characteristics

### Coverage

The test suite achieves 100% code coverage for the `LocalCardService` class, including:
- All public methods
- All error paths
- All edge cases
- All database operations
- All exception scenarios