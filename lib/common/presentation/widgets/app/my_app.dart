import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/constants/constants.dart';
// need to run
// dart run build_runner build
// dart run slang
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/app/themes/base_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart'
    show FlutterI18n, FlutterI18nDelegate;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

abstract class MyAppNavigation {
  RouterConfig<RouteMatchList> router();
}

class MyApp extends StatelessWidget {
  final MyAppNavigation navigation;
  final ValueNotifier<ThemeMode> themeMode;
  final FlutterI18nDelegate flutterI18nDelegate;

  const MyApp({
    super.key,
    required this.navigation,
    required this.themeMode,
    required this.flutterI18nDelegate,
  });

  void systemColor() {
    final isDark = themeMode.value == ThemeMode.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark ? AppColors.mainBlack : AppColors.mainWhite,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            isDark ? AppColors.mainBlack : AppColors.mainWhite,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) debugPrintRebuildDirtyWidgets = true;

    return ValueListenableBuilder(
      valueListenable: themeMode,
      builder: (context, value, child) {
        systemColor();
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: snackbarKey,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode.value,
          routerConfig: navigation.router(),
          locale: TranslationProvider.of(context).flutterLocale,
          builder: FlutterI18n.rootAppBuilder(),
          localizationsDelegates: [
            flutterI18nDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru'), Locale('en')],
        );
      },
    );
  }
}
