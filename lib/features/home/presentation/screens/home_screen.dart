import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
          onPressed: () async {
            await SecureStorage().write(key: SecureKeys.lang.name, value: 'ru');
            LocaleSettings.setLocale(AppLocale.ru);
            await FlutterI18n.refresh(context, LocaleClass.lngRu);
          },
          // themeMode.value =
          //     themeMode.value == ThemeMode.light
          //         ? ThemeMode.dark
          //         : ThemeMode.light,
        ),

        body: SafeArea(
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [_AppBar()],
            body: TabBarView(children: [_GridCards(), SettingsPage()]),
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
                  t.screen.home.name,
                  style: context.textStyles.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
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
          (_, index) => Container(
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
          ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of setting items to display in the grid
    final List<String> settingItems = [
      'Account',
      'Notifications',
      'Privacy',
      'Security',
      'Display',
      'Language',
      'Help & Support',
      'About',
      'Logout',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        // No search bar in the app bar, as per the image layout
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:
        // Grid view of settings items
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero, // Remove default padding
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6, // Adjust aspect ratio for card height
            ),
            itemCount: settingItems.length,
            itemBuilder: (context, index) {
              return _CustomFlipCard(title: settingItems[index]);
            },
          ),
        ),
      ),
    );
  }
}

class _CustomFlipCard extends StatelessWidget {
  const _CustomFlipCard({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: FlipCardController(),
      rotateSide: RotateSide.left,
      animationDuration: Duration(milliseconds: 500),
      onTapFlipping: true,
      frontWidget: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGrey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backWidget: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGrey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: context.textStyles.displaySmall,

            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
