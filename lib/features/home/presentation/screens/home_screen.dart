import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/services/local_crud/card_service.dart';
import 'package:card_holder/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

part '../parts/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              CardService().createCard(code: 'testCode_2');
              // CardService().deleteCard(id: 2);
            } catch (e) {
              print(e);
            }
          },
        ),

        body: NestedScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [_AppBar()],
          body: TabBarView(children: [_GridCards(), SettingsPage()]),
        ),
      ),
    );
  }
}

class _GridCards extends StatelessWidget {
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
      itemCount: 100,
      itemBuilder: (_, index) => _CardItem(index),
    );
  }
}

class _CardItem extends StatefulWidget {
  const _CardItem(this.index);
  final int index;

  @override
  State<_CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<_CardItem> {
  DataBaseCards? cardInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: mainBoxShadow,
      ),
      child: Center(
        child: SizedBox(
          height: 100,
          child: TextButton(
            onPressed: () async {
              setState(() async {
                cardInfo = await CardService().openCard(
                  index: widget.index + 1,
                );
              });
            },
            child: Text(
              'code ${cardInfo?.code}, usage ${cardInfo?.usagePoint} ',
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
