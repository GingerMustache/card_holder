import 'package:card_holder/common/constants/constants.dart';
import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/services/di_container/di_container.dart';
import 'package:card_holder/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum MainRoutes { home, init }

String mainRoutesName(MainRoutes name) => switch (name) {
  MainRoutes.init => 'InitScreen',
  MainRoutes.home => 'HomeScreen',
};

String mainRoutesPath(MainRoutes name) => switch (name) {
  MainRoutes.init => '/',
  MainRoutes.home => '/home',
};

class MainNavigation implements MyAppNavigation {
  final ScreenFactory screenFactory;

  MainNavigation({required this.screenFactory});

  @override
  RouterConfig<RouteMatchList> router() => GoRouter(
    initialLocation: mainRoutesPath(MainRoutes.home),
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: mainRoutesName(MainRoutes.home),
        path: mainRoutesPath(MainRoutes.home),
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeHomeScree();
        },
      ),
    ],
  );
}

class ScreenFactory {
  final DiContainer diContainer;
  final ValueNotifier<ThemeMode> themeMode;

  ScreenFactory({required this.diContainer, required this.themeMode});

  Widget makeHomeScree() {
    return HomeScreen(themeMode: themeMode);
  }
}
