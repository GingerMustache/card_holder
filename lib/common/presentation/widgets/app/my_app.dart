import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/constants/constants.dart';
// need to run
// dart run build_runner build
// dart run slang
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/app/themes/base_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

abstract class MyAppNavigation {
  RouterConfig<RouteMatchList> router();
}

class MyApp extends StatelessWidget {
  final MyAppNavigation navigation;
  final ValueNotifier<ThemeMode> themeMode;

  const MyApp({super.key, required this.navigation, required this.themeMode});

  systemColor() {
    final isDark = themeMode.value == ThemeMode.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark ? AppColors.mainBlack : AppColors.mainWhite,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
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
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
        );
      },
    );
  }
}
