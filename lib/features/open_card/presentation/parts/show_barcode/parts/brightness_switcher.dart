part of '../../../card_open_sheet.dart';

class _BrightnessSwitcher extends StatelessWidget {
  const _BrightnessSwitcher();

  onLightTap(BuildContext context) =>
      context.read<OpenCardBloc>().add(OpenCardChangeBrightnessEvent());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          width: 57,
          height: 32,
          child: Center(
            child: BlocBuilder<OpenCardBloc, OpenCardState>(
              buildWhen:
                  (prev, cur) => prev.turnBrightnessOn != cur.turnBrightnessOn,
              builder: (context, state) {
                final isBrightnessOn = state.turnBrightnessOn;

                return Text(
                  textAlign: TextAlign.right,
                  t.system.bright.all,
                  style: context.textStyles.labelSmall?.copyWith(
                    color:
                        isBrightnessOn ? AppColors.darkGrey : AppColors.mainRed,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ).onTap(() => onLightTap(context));
  }
}
