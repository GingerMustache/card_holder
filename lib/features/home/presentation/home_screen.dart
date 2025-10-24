// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/color_mark/color_mark.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/presentation/widgets/logo_svg/logo_svg.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/features/add_new_card/presentation/template_card_sheet/template_card_sheet.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/open_card/presentation/card_open_sheet.dart';
import 'package:card_holder/features/settings/bloc/settings_bloc.dart';
import 'package:card_holder/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'parts/app_bar.dart';
part 'parts/card_item.dart';
part 'parts/fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _Fab(),
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [_AppBar(_tabController)],
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocBuilder<CardsBloc, CardsState>(
              builder: (context, state) {
                final cards =
                    state.searchListCards.isNotEmpty
                        ? state.searchListCards
                        : state.cards;
                return _GridCards(cards: cards);
              },
            ),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}

class _GridCards extends StatelessWidget {
  const _GridCards({required this.cards});

  final List<DataBaseCard> cards;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Center(
        child: Text(t.screen.home.empty, style: context.textStyles.bodyMedium),
      );
    }
    return GridView.builder(
      padding: mainPadding,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 13,
        crossAxisSpacing: 13,
        childAspectRatio: 1.5,
      ),

      itemCount: cards.length,
      itemBuilder: (_, index) => _CardItem(cards[index], index),
    );
  }
}
