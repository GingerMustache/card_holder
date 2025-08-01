part of '../../../home/presentation/screens/home_screen.dart';

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
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

    return Padding(
      padding: mainPadding,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.6,
        ),
        itemCount: settingItems.length,
        itemBuilder: (context, index) {
          return _FlipCard(title: settingItems[index], index);
        },
      ),
    );
  }
}
