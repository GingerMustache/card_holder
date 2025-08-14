// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/services/local_crud/card_service.dart';
import 'package:card_holder/common/sheets/add_card_sheet/add_card_sheet.dart';
import 'package:card_holder/common/sheets/card_open_sheet.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

part '../parts/app_bar.dart';
part '../parts/fab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: _Fab(),

        body: NestedScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [_AppBar()],
          body: TabBarView(
            children: [
              BlocBuilder<CardsBloc, CardsState>(
                builder: (context, state) {
                  return _GridCards(cards: state.cards);
                },
              ),
              SettingsPage(),
            ],
          ),
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
    return MasonryGridView.count(
      padding: mainPadding,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: cards.length,
      itemBuilder: (_, index) => _CardItem(cards[index], index),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem(this.card, this.currentIndex);

  final DataBaseCard? card;
  final int currentIndex;

  void onPressed(BuildContext context) async {
    context.read<CardsBloc>().add(
      CardsOpenCardEvent(id: card?.id, index: currentIndex),
    );

    CardOpenSheet.show(context, card?.code ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mainBoxDecoration(context),

      child: Center(
        child: SizedBox(
          height: 110,
          child: TextButton(
            onPressed: () => onPressed(context),
            child: Text(
              'code - ${card?.code},\nusage - ${card?.usagePoint} ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
