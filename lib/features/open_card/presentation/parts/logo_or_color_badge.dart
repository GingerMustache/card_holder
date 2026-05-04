part of '../card_open_sheet.dart';

class LogoOrColorBadge extends StatelessWidget {
  const LogoOrColorBadge(this.curCard, {super.key});

  final DataBaseCard curCard;

  void onTapColorWidget(BuildContext ctx) =>
      ctx.read<OpenCardBloc>().add(OpenCardChangeMarkTapEvent());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.color.onSurface.withAlpha(50))),
        curCard.urlPath.isNotEmpty
            ? LogoSvg(
              logoSize: curCard.logoSize,
              urlPath: curCard.urlPath,
              cardName: curCard.name,
            )
            : BlocBuilder<OpenCardBloc, OpenCardState>(
              buildWhen: (previous, current) => previous.color != current.color,
              builder: (context, state) {
                return InkWell(
                  onTap: () => onTapColorWidget(context),
                  child: ColorMark(state.color),
                );
              },
            ),
      ],
    );
  }
}
