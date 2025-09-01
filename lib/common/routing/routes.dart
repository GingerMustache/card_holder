import 'package:card_holder/common/constants/constants.dart';
import 'package:card_holder/common/di_container/di_container.dart';
import 'package:card_holder/common/presentation/widgets/app/my_app.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  ScreenFactory({required this.diContainer});

  Widget makeHomeScree() {
    return BlocProvider(
      lazy: false,
      create:
          (context) =>
              CardsBloc(cardRepo: diContainer.makeCardRepository())
                ..add(CardsFetchCardsEvent()),
      child: HomeScreen(),
    );
  }
}
