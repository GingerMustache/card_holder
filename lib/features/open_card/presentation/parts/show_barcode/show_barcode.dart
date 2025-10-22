part of '../../card_open_sheet.dart';

class _ShowBarcode extends StatelessWidget {
  const _ShowBarcode({
    required this.allBorderRadius,
    required this.boxDecoration,
    required this.pickTime,
    required this.currentCardId,
    required this.barcodeKey,
  });

  final BorderRadius allBorderRadius;
  final BoxDecoration boxDecoration;
  final int pickTime;
  final int currentCardId;
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
              padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
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
            _PickTimeText(pickTime: pickTime),
            _DeleteButton(currentCardId),
          ],
        ),
      ),
    );
  }
}
