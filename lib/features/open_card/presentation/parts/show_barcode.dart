part of '../card_open_sheet.dart';

class _ShowBarcode extends StatelessWidget {
  const _ShowBarcode({
    required this.allBorderRadius,
    required this.boxDecoration,
    required this.pickTime,
  });

  final BorderRadius allBorderRadius;
  final BoxDecoration boxDecoration;
  final int pickTime;

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
                      return BarcodeWidget(
                        barcode: Barcode.code128(),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        width: double.infinity,
                        height: 200,
                        data: state.currentCard?.code ?? '',
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
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
