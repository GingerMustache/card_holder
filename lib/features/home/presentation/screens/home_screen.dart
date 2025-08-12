// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/services/local_crud/card_service.dart';
import 'package:card_holder/common/sheets/card_open_sheet.dart';
import 'package:card_holder/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

part '../parts/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DataBaseCard> cards = [];

  @override
  void initState() {
    super.initState();
    initCards();
  }

  Future<void> initCards() async {
    final uploadCards = await CardService().getAllCards();
    setState(() {
      cards.addAll(uploadCards);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.mainWhite,
            borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkGrey.withValues(alpha: 0.12),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: FloatingActionButton.small(
            elevation: 0,
            backgroundColor: AppColors.mainWhite,
            child: Text(
              t.screen.home.add,
              style: context.textStyles.labelSmall,
            ),
            onPressed: () async {
              try {
                final newCard = await CardService().createCard(
                  code: 'testCode_4',
                );
                setState(() {
                  cards.add(newCard);
                });
                // CardOpenSheet.show(context);
                // CardService().deleteCard(id: 2);
              } catch (e) {
                print(e);
              }
            },
          ),
        ),

        body: NestedScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [_AppBar()],
          body: TabBarView(
            children: [_GridCards(cards: cards), SettingsPage()],
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
      itemBuilder: (_, index) => _CardItem(cards[index]),
    );
  }
}

class _CardItem extends StatefulWidget {
  const _CardItem(this.cardInfo);

  final DataBaseCard? cardInfo;

  @override
  State<_CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<_CardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mainBoxDecoration(context),

      child: Center(
        child: SizedBox(
          height: 100,
          child: TextButton(
            onPressed: () async {
              CardOpenSheet.show(context, widget.cardInfo?.code ?? '');
              // setState(() async {
              //   final openedCard = await CardService().openCard(
              //     index: widget.cardInfo?.id ?? 0,
              //   );
              //   print('openedCard = $openedCard');
              // });
            },
            child: Text(
              'code - ${widget.cardInfo?.code},\nusage - ${widget.cardInfo?.usagePoint} ',
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
