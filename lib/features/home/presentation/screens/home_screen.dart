import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.themeMode});

  final ValueNotifier<ThemeMode> themeMode;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed:
              () =>
                  themeMode.value =
                      themeMode.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light,
        ),

        body: SafeArea(
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [_AppBar()],
            body: TabBarView(children: [_GridCards(), _GridCards()]),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      floating: true,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Padding(
          padding: mainPadding,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Card Holder',
                  style: context.textStyles.headlineLarge,
                ),
              ),
              18.h,
              InputSearch(change: (String? value) {}, clear: () {}),
              Container(
                decoration: _dividerDecor(),
                height: 30,

                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.only(right: 8),
                  dividerColor: Colors.transparent,
                  indicator: UnderlineTabIndicator(),
                  unselectedLabelStyle: context.textStyles.bodySmall,
                  labelStyle: context.textStyles.titleSmall,
                  splashFactory: NoSplash.splashFactory,
                  isScrollable: true,
                  tabs: [Text('Cards'), Text('Settings')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _dividerDecor() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.subGrey.withAlpha(50)),
      ),
    );
  }
}

class _GridCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: 100,
      itemBuilder:
          (context, index) => Container(
            decoration: BoxDecoration(
              color: AppColors.mainGray,
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
          ),
    );
  }
}
