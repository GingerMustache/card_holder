part of '../../../screens/settings_screen.dart';

class _ChooseTheme extends StatelessWidget {
  const _ChooseTheme();
  void _onThemeSelected(BuildContext context, ThemeMode theme) async {
    HapticFeedback.mediumImpact();
    context.read<SettingsBloc>().add(SettingChangeThemeEvent(theme: theme));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen:
          (previous, current) =>
              previous.theme != current.theme || previous.lang != current.lang,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CardTab(
              tabName: t.system.theme.dark,
              isSelected: state.theme == ThemeMode.dark,
              onTap: () => _onThemeSelected(context, ThemeMode.dark),
            ),
            _CardTab(
              tabName: t.system.theme.light,
              isSelected: state.theme == ThemeMode.light,
              onTap: () => _onThemeSelected(context, ThemeMode.light),
            ),
          ],
        );
      },
    );
  }
}
