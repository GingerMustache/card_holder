import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/secure_storage.dart';
import 'package:card_holder/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

part '../parts/flip_card/flip_card.dart';
part '../parts/flip_card/parts/choose_lang.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> settingItems = [
      'Theme',
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
