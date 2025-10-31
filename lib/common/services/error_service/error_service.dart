import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class _SentryConfig {
  static FutureOr<void> options(SentryFlutterOptions options) {
    options.dsn = dotenv.env['SENTRY_DSN'];
    options.tracesSampleRate = 0.2; // Performance monitoring
    options.profilesSampleRate = 0.2; // Optional profiling
    options.debug = false;
  }
}

class MainErrorService {
  static MainErrorService? _instance;
  late final Talker _talker;

  MainErrorService._();

  get talker => _talker;

  static MainErrorService get instance {
    _instance ??= MainErrorService._();
    return _instance!;
  }

  void initialize() {
    _talker = TalkerFlutter.init();

    FlutterError.onError = (FlutterErrorDetails details) {
      _reportError(details.exception, details.stack ?? StackTrace.current);
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      _reportError(error, stack);
      return true;
    };

    _talker.info('Init ErrorService ');
  }

  Future<void> _reportError(dynamic error, StackTrace stackTrace) async {
    if (kDebugMode) {
      _talker.handle(error, stackTrace);
    }
  }

  Future<void> reportError(dynamic error, [StackTrace? stackTrace]) async {
    await _reportError(error, stackTrace ?? StackTrace.current);
  }

  void runGuarded(void Function() body) async {
    SentryWidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: '.env');

    await SentryFlutter.init(
      _SentryConfig.options,
      appRunner: () async {
        body;
        (error, stackTrace) => _reportError(error, stackTrace);
      },
    );
  }
}
