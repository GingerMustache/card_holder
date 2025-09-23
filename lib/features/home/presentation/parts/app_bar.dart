part of '../screens/home_screen.dart';

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
          padding: mainHorizontalPadding,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t.screen.home.name,
                  style: context.textStyles.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              18.h,
              InputSearch(
                change:
                    (String? value) =>
                        context.read<CardsBloc>().add(CardsSearchEvent(value)),
                clear: () {},
              ),
              Container(
                decoration: dividerDecor,
                height: 30,

                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.only(right: 8),
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(color: Colors.transparent),
                  unselectedLabelStyle: context.textStyles.bodySmall,
                  labelStyle: context.textStyles.titleSmall,
                  splashFactory: NoSplash.splashFactory,
                  isScrollable: true,
                  tabs: [Text(t.tabs.card), Text(t.tabs.setting)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
