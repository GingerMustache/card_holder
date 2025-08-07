part of '../../../screens/settings_screen.dart';

class _ChooseLang extends StatelessWidget {
  const _ChooseLang();

  void _onLanguageSelected(BuildContext context, String lang) async {
    HapticFeedback.mediumImpact();
    context.read<SettingsBloc>().add(SettingChangeLangEvent(lang: lang));

    await FlutterI18n.refresh(
      context,
      lang == 'ru' ? LocaleClass.lngRu : LocaleClass.lngEn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) => previous.lang != current.lang,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CardTab(
              tabName: t.system.lang.ru,
              isSelected: state.lang == 'ru',
              onTap: () => _onLanguageSelected(context, 'ru'),
            ),
            _CardTab(
              tabName: t.system.lang.en,
              isSelected: state.lang == 'en',
              onTap: () => _onLanguageSelected(context, 'en'),
            ),
          ],
        );
      },
    );
  }
}
