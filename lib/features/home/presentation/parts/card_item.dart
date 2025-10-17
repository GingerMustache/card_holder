part of '../home_screen.dart';

class _CardItem extends StatelessWidget {
  const _CardItem(this.card, this.currentIndex);

  final DataBaseCard? card;
  final int currentIndex;

  void onPressed(BuildContext context) {
    final completer = Completer<DataBaseCard>();

    context.read<CardsBloc>().add(
      CardsOpenCardEvent(
        id: card?.id,
        index: currentIndex,
        completer: completer,
      ),
    );
    completer.future.then(
      (currentCard) => CardOpenSheet.show(context, currentCard),
    );
  }

  // item container
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mainBoxDecoration(),
      child: Stack(
        children: [
          if (card?.urlPath.isEmpty ?? true)
            Align(
              alignment: Alignment(1, -1),
              child: ColorMark(
                card?.color ?? 0x00000000,
                needText: false,
                heigh: 20,
              ),
            ),
          Positioned.fill(
            child: TextButton(
              onPressed: () => onPressed(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child:
                    card?.urlPath.isNotEmpty ?? false
                        ? SvgPicture.asset(
                          card?.urlPath ?? '',
                          height: card!.logoSize,
                          width: card!.logoSize,
                          fit: BoxFit.contain,
                          placeholderBuilder:
                              (context) => _LogoText(card: card),
                        )
                        : _LogoText(card: card),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoText extends StatelessWidget {
  const _LogoText({required this.card});

  final DataBaseCard? card;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      card?.name ?? '',
      textAlign: TextAlign.center,
      style: context.textStyles.bodySmall,
    );
  }
}
