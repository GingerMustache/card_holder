import 'dart:async';

import 'package:card_holder/common/constants/constants.dart';
import 'package:card_holder/common/di_container/di_container.dart';
import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/common/services/error_service/error_service.dart';
import 'package:card_holder/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

enum MainRoutes { home }

String mainRoutesName(MainRoutes name) => switch (name) {
  MainRoutes.home => 'HomeScreen',
};

String mainRoutesPath(MainRoutes name) => switch (name) {
  MainRoutes.home => '/',
};

class MainNavigation implements MyAppNavigation {
  final ScreenFactory screenFactory;

  MainNavigation({required this.screenFactory});

  @override
  RouterConfig<RouteMatchList> router() => GoRouter(
    redirect: _jsonOpeningRedirect,
    initialLocation: mainRoutesPath(MainRoutes.home),
    navigatorKey: navigatorKey,
    observers: [TalkerRouteObserver(MainErrorService.instance.talker)],
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

  FutureOr<String?> _jsonOpeningRedirect(
    BuildContext context,
    GoRouterState state,
  ) {
    final location = state.uri.toString();

    if (location.startsWith('content://') || location.startsWith('file://')) {
      return '/';
    }
    return null;
  }
}

class ScreenFactory {
  final DiContainer diContainer;

  ScreenFactory({required this.diContainer});

  Widget makeHomeScree() {
    return HomeScreen();
  }
}
