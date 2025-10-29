import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Service for handling and reporting errors in the Flutter application
class ErrorService {
  static ErrorService? _instance;
  late final Talker _talker;

  ErrorService._();

  /// Singleton instance of ErrorService
  static ErrorService get instance {
    _instance ??= ErrorService._();
    return _instance!;
  }

  /// Initialize error handling for the application
  /// Should be called before runApp()
  void initialize() {
    _talker = TalkerFlutter.init();

    FlutterError.onError = (FlutterErrorDetails details) {
      _reportError(details.exception, details.stack ?? StackTrace.current);
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      _reportError(error, stack);
      return true; // Indicates the error was handled
    };

    _talker.info('Init ErrorService ');
  }

  /// Report an error with stack trace
  /// This method can be extended to send errors to crash reporting services
  Future<void> _reportError(dynamic error, StackTrace stackTrace) async {
    if (kDebugMode) {
      _talker.handle(error, stackTrace);
    }
  }

  /// Manually report an error
  /// Use this method to report custom errors from your code
  Future<void> reportError(dynamic error, [StackTrace? stackTrace]) async {
    await _reportError(error, stackTrace ?? StackTrace.current);
  }

  /// Run code in a guarded zone with error handling
  /// This wraps runZonedGuarded for convenience
  void runGuarded(void Function() body) {
    runZonedGuarded(
      body,
      (error, stackTrace) => _reportError(error, stackTrace),
    );
  }
}
