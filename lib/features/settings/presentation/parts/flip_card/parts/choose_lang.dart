part of '../../../screens/settings_screen.dart';

class _ChooseLang extends StatelessWidget {
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
            _LangTab(
              lang: 'ru',
              isSelected: state.lang == 'ru',
              onTap: () => _onLanguageSelected(context, 'ru'),
            ),
            _LangTab(
              lang: 'en',
              isSelected: state.lang == 'en',
              onTap: () => _onLanguageSelected(context, 'en'),
            ),
          ],
        );
      },
    );
  }
}

class _LangTab extends StatelessWidget {
  const _LangTab({
    required this.lang,
    required this.isSelected,
    required this.onTap,
  });
  final String lang;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          lang,
          style:
              isSelected
                  ? context.textStyles.titleSmall
                  : context.textStyles.bodySmall,
        ),
      ),
    );
  }
}
