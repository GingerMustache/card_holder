part of '../add_card_sheet.dart';

class _ColorMarkWidget extends StatelessWidget {
  const _ColorMarkWidget();

  void onTap(BuildContext context) =>
      context.read<CreateCardBloc>().add(CreateCardChangeMarkTapEvent());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1, -0.9),
      child: InkWell(
        onTap: () => onTap(context),
        child: BlocBuilder<CreateCardBloc, CreateCardState>(
          buildWhen: (previous, current) => previous.color != current.color,
          builder: (context, state) {
            return ColorMark(state.color);
          },
        ),
      ),
    );
  }
}
