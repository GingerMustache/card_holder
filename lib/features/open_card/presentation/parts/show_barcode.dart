part of '../card_open_sheet.dart';

class _ShowBarcode extends StatelessWidget {
  const _ShowBarcode({
    required this.allBorderRadius,
    required this.boxDecoration,
    required this.pickTime,
    required this.barcodeKey,
  });

  final BorderRadius allBorderRadius;
  final BoxDecoration boxDecoration;
  final int pickTime;
  final GlobalKey barcodeKey;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.15,
      child: ClipRRect(
        borderRadius: allBorderRadius,
        child: Stack(
          children: [
            Container(
              color: AppColors.subGrey.withAlpha(50),
              padding: EdgeInsets.all(35),
              child: Container(
                decoration: boxDecoration.copyWith(
                  color: AppColors.mainWhite,
                  borderRadius: allBorderRadius,
                ),
                child: Center(
                  child: BlocBuilder<CardsBloc, CardsState>(
                    builder: (context, state) {
                      return RepaintBoundary(
                        key: barcodeKey,
                        child: BarcodeWidget(
                          barcode: Barcode.code128(),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity,
                          height: 200,
                          data: state.currentCard?.code ?? '',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            _BrightnessSwitcher(),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$pickTime ${t.screen.home.openCard.uses}',
                  style: context.textStyles.labelSmall?.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrightnessSwitcher extends StatelessWidget {
  const _BrightnessSwitcher();

  onLightTap(BuildContext context) =>
      context.read<OpenCardBloc>().add(OpenCardChangeBrightnessEvent());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: InkWell(
        onTap: () => onLightTap(context),
        splashFactory: null,
        child: Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 57,
            height: 32,
            child: Center(
              child: BlocBuilder<OpenCardBloc, OpenCardState>(
                buildWhen:
                    (prev, cur) =>
                        prev.turnBrightnessOn != cur.turnBrightnessOn,
                builder: (context, state) {
                  final isBrightnessOn = state.turnBrightnessOn;

                  return Text(
                    textAlign: TextAlign.right,
                    t.system.bright.all,
                    style: context.textStyles.labelSmall?.copyWith(
                      color:
                          isBrightnessOn
                              ? AppColors.darkGrey
                              : AppColors.mainRed,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
