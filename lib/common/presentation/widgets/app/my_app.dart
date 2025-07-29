import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/constants/constants.dart';
// need to run
// dart run build_runner build
// dart run slang
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

abstract class MyAppNavigation {
  RouterConfig<RouteMatchList> router();
}

class MyApp extends StatelessWidget {
  final MyAppNavigation navigation;

  const MyApp({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainBlack,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        fontFamily: 'ChackraPetch',
        indicatorColor: AppColors.mainBlack,
        iconTheme: const IconThemeData(color: AppColors.mainBlack),
      ),
      routerConfig: navigation.router(),
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
