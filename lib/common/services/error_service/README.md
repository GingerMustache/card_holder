# ErrorService

A centralized service for handling and reporting errors in the Flutter application.

## Features

- Automatic handling of Flutter framework errors
- Automatic handling of platform errors (native code, plugins)
- Manual error reporting capability
- Singleton pattern for easy access
- Debug mode logging
- Ready for crash reporting service integration

## Usage

### Initialization

The ErrorService is automatically initialized in `main.dart`:

```dart
void main() async {
  // Initialize error handling
  ErrorService.instance.initialize();
  
  // Rest of your app initialization...
}
```

### Manual Error Reporting

You can manually report errors from anywhere in your application:

```dart
try {
  // Some risky operation
  await riskyOperation();
} catch (error, stackTrace) {
  // Report the error
  await ErrorService.instance.reportError(error, stackTrace);
  
  // Handle the error in your UI
  showErrorDialog(context, error.toString());
}
```

### Running Code in Guarded Zone

For additional protection, you can run code in a guarded zone:

```dart
ErrorService.instance.runGuarded(
  () {
    // Your code here
    performSomeOperation();
  },
  (error, stackTrace) {
    // Custom error handling (optional)
    print('Custom error handler: $error');
  },
);
```

## Integration with Crash Reporting

To integrate with crash reporting services like Firebase Crashlytics, modify the `_reportError` method in `error_service.dart`:

```dart
Future<void> _reportError(dynamic error, StackTrace stackTrace) async {
  if (kDebugMode) {
    debugPrint('Caught error: $error');
    debugPrint('Stack trace: $stackTrace');
  }
  
  // Add crash reporting service integration
  // FirebaseCrashlytics.instance.recordError(error, stackTrace);
}
```

## Architecture

The ErrorService follows the singleton pattern and is integrated into the dependency injection container for consistency with the rest of the application architecture.