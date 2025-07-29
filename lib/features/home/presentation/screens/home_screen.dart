import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/spaces.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Card Holder',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              18.h,
              InputSearch(
                change: (String? value) {
                  print('Search value changed: $value');
                },
                clear: () {
                  print('Search cleared');
                },
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.subGrey.withAlpha(50)),
                  ),
                ),
                height: 30,

                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.only(right: 8),
                  dividerColor: Colors.transparent,
                  indicator: UnderlineTabIndicator(),
                  labelColor: AppColors.mainBlack,
                  unselectedLabelColor: AppColors.darkGrey,
                  splashFactory: NoSplash.splashFactory,
                  isScrollable: true,
                  tabs: [Text('Cards'), Tab(text: 'Settings')],
                ),
              ),
            ],
          ),
        ),
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
