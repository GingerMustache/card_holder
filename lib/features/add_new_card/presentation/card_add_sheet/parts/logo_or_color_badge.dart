part of '../card_add_sheet.dart';

class _LogoOrColorBadge extends StatelessWidget {
  const _LogoOrColorBadge(this.state);

  final CreateCardState state;

  void onTapColorWidget(BuildContext ctx) =>
      ctx.read<CreateCardBloc>().add(CreateCardChangeMarkTapEvent());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.color.onSurface.withAlpha(50))),
        state.urlPath.isNotEmpty
            ? LogoSvg(
              logoSize: state.logoSize,
              urlPath: state.urlPath,
              cardName: state.name,
            )
            : BlocBuilder<CreateCardBloc, CreateCardState>(
              buildWhen: (previous, current) => previous.color != current.color,
              builder: (context, state) {
                return ColorMarkWidget(
                  initColor: state.color,
                  onTap: () => onTapColorWidget(context),
                );
              },
            ),
      ],
    );
  }
}
