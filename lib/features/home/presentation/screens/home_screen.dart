import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
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
        floatingActionButton: FloatingActionButton(onPressed: () async {}),

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

class _CardItem extends StatelessWidget {
  const _CardItem(this.index);
  final int index;

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
          child: Text(
            'Item ${index + 1}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
