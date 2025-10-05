import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/localization/locale/locale.dart';
import 'package:card_holder/common/services/brightness_control/brightness_control_service.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

part '../parts/flip_card/card_tab.dart';
part '../parts/flip_card/flip_card.dart';
part '../parts/flip_card/parts/choose_brightness.dart';
part '../parts/flip_card/parts/choose_lang.dart';
part '../parts/flip_card/parts/choose_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mainPadding,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final settings =
              state.searchItems.isNotEmpty
                  ? state.searchItems
                  : state.settingItems;
          return GridView.builder(
            addAutomaticKeepAlives: false,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.6,
            ),
            itemCount: settings.length,
            itemBuilder: (context, index) {
              return _FlipCard(title: settings[index], index);
            },
          );
        },
      ),
    );
  }
}
