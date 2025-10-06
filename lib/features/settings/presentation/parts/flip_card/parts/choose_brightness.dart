part of '../../../screens/settings_screen.dart';

class _ChooseBrightness extends StatelessWidget {
  const _ChooseBrightness();

  void _onBrightnessSelected(BuildContext context, BrightnessMode mode) async {
    HapticFeedback.mediumImpact();
    context.read<SettingsBloc>().add(SettingChangeBrightnessEvent(mode: mode));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen:
          (previous, current) =>
              previous.brightnessMode != current.brightnessMode,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CardTab(
              tabName: t.system.bright.auto,
              isSelected: state.brightnessMode == BrightnessMode.auto,
              onTap: () => _onBrightnessSelected(context, BrightnessMode.auto),
            ),
            _CardTab(
              tabName: t.system.bright.handle,
              isSelected: state.brightnessMode == BrightnessMode.handle,
              onTap:
                  () => _onBrightnessSelected(context, BrightnessMode.handle),
            ),
          ],
        );
      },
    );
  }
}
