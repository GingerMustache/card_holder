part of '../home_screen.dart';

class _AppBar extends StatelessWidget {
  final TabController _tabController;

  const _AppBar(this._tabController);

  onChange(String? value, BuildContext context, int page) {
    if (value != null && value.isEmpty) {
      context.read<CardsBloc>().add(CardsSearchEvent(value));
      context.read<SettingsBloc>().add(SettingSearchEvent(query: value));
    } else {
      page == 0
          ? context.read<CardsBloc>().add(CardsSearchEvent(value))
          : context.read<SettingsBloc>().add(SettingSearchEvent(query: value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
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
                        onChange(value, context, _tabController.index),
              ),
              Container(
                decoration: dividerDecor,
                height: 30,

                child: TabBar(
                  controller: _tabController,
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
