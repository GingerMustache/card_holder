part of '../template_card_sheet.dart';

class FloppyDiskContainer extends StatelessWidget {
  const FloppyDiskContainer({super.key});

  Future<void> onAddFile(BuildContext context) async {
    final completer = Completer<DataBaseCard>();
    context.read<CardsBloc>().add(CardsAddFileCardEvent(completer: completer));

    completer.future.then((_) => context.pop());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        return TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => onAddFile(context),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black,
                width: _FloppyDiskConstants.borderWidth,
              ),
            ),
            child: Stack(
              children: [
                _GrayTopSection(size: size),
                _SliderOutline(size: size),
                _RightBlueSquare(size: size),
                _WhiteLabelArea(size: size),
                _BottomLeftSmallSquare(size: size),
                _BottomRightSmallSquare(size: size),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FloppyDiskConstants {
  static const double borderWidth = 2;
  static const double grayTopSectionHeightRatio = 0.25;
  static const double grayTopSectionLeftRatio = 0.13;
  static const double grayTopSectionRightRatio = 0.23;
  static const double sliderOutlineTopRatio = 0.02;
  static const double sliderOutlineLeftRatio = 0.2;
  static const double sliderOutlineWidthRatio = 0.1;
  static const double sliderOutlineHeightRatio = 0.2;
  static const double rightBlueSquareRightRatio = 0.135;
  static const double rightBlueSquareWidthRatio = 0.1;
  static const double rightBlueSquareHeightRatio = 0.2;
  static const double whiteLabelAreaBottomRatio = 0.05;
  static const double whiteLabelAreaLeftRightRatio = 0.17;
  static const double whiteLabelAreaHeightRatio = 0.22;
  static const double whiteLabelLineVerticalMarginRatio = 0.01;
  static const double whiteLabelLineHeight = 2;
  static const double whiteLabelFontSizeRatio = 0.055;
  static const double bottomLeftRightSmallSquareBottomRatio = 0.02;
  static const double bottomLeftRightSmallSquareLeftRightRatio = 0.05;
  static const double bottomLeftRightSmallSquareWidthHeightRatio = 0.05;
  static const double smallSquareBorderWidth = 1;
}

class _GrayTopSection extends StatelessWidget {
  final double size;
  const _GrayTopSection({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: _FloppyDiskConstants.grayTopSectionLeftRatio * size,
      right: _FloppyDiskConstants.grayTopSectionRightRatio * size,
      child: Container(
        height: _FloppyDiskConstants.grayTopSectionHeightRatio * size,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          border: Border.all(
            color: Colors.black,
            width: _FloppyDiskConstants.smallSquareBorderWidth,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}

class _SliderOutline extends StatelessWidget {
  final double size;
  const _SliderOutline({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _FloppyDiskConstants.sliderOutlineTopRatio * size,
      left: _FloppyDiskConstants.sliderOutlineLeftRatio * size,
      child: Container(
        width: _FloppyDiskConstants.sliderOutlineWidthRatio * size,
        height: _FloppyDiskConstants.sliderOutlineHeightRatio * size,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: _FloppyDiskConstants.smallSquareBorderWidth,
          ),
        ),
        child: Container(color: Colors.blue[700]),
      ),
    );
  }
}

class _RightBlueSquare extends StatelessWidget {
  final double size;
  const _RightBlueSquare({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: _FloppyDiskConstants.rightBlueSquareRightRatio * size,
      child: Container(
        width: _FloppyDiskConstants.rightBlueSquareWidthRatio * size,
        height: _FloppyDiskConstants.rightBlueSquareHeightRatio * size,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: _FloppyDiskConstants.smallSquareBorderWidth,
          ),
        ),
        child: Container(color: Colors.blue[700]),
      ),
    );
  }
}

class _WhiteLabelArea extends StatelessWidget {
  final double size;
  const _WhiteLabelArea({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _FloppyDiskConstants.whiteLabelAreaBottomRatio * size,
      left: _FloppyDiskConstants.whiteLabelAreaLeftRightRatio * size,
      right: _FloppyDiskConstants.whiteLabelAreaLeftRightRatio * size,
      child: Container(
        height: _FloppyDiskConstants.whiteLabelAreaHeightRatio * size,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              2,
              (index) => Container(
                margin: EdgeInsets.symmetric(
                  vertical:
                      _FloppyDiskConstants.whiteLabelLineVerticalMarginRatio *
                      size,
                ),
                height: _FloppyDiskConstants.whiteLabelLineHeight,
                color: Colors.black,
              ),
            ),
            Text(
              t.shops.fromFile,
              style: context.textStyles.titleSmall?.copyWith(
                fontSize: _FloppyDiskConstants.whiteLabelFontSizeRatio * size,
              ),
            ),
            ...List.generate(
              2,
              (index) => Container(
                margin: EdgeInsets.symmetric(
                  vertical:
                      _FloppyDiskConstants.whiteLabelLineVerticalMarginRatio *
                      size,
                ),
                height: _FloppyDiskConstants.whiteLabelLineHeight,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomLeftSmallSquare extends StatelessWidget {
  final double size;
  const _BottomLeftSmallSquare({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _FloppyDiskConstants.bottomLeftRightSmallSquareBottomRatio * size,
      left:
          _FloppyDiskConstants.bottomLeftRightSmallSquareLeftRightRatio * size,
      child: Container(
        width:
            _FloppyDiskConstants.bottomLeftRightSmallSquareWidthHeightRatio *
            size,
        height:
            _FloppyDiskConstants.bottomLeftRightSmallSquareWidthHeightRatio *
            size,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: _FloppyDiskConstants.smallSquareBorderWidth,
          ),
        ),
      ),
    );
  }
}

class _BottomRightSmallSquare extends StatelessWidget {
  final double size;
  const _BottomRightSmallSquare({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _FloppyDiskConstants.bottomLeftRightSmallSquareBottomRatio * size,
      right:
          _FloppyDiskConstants.bottomLeftRightSmallSquareLeftRightRatio * size,
      child: Container(
        width:
            _FloppyDiskConstants.bottomLeftRightSmallSquareWidthHeightRatio *
            size,
        height:
            _FloppyDiskConstants.bottomLeftRightSmallSquareWidthHeightRatio *
            size,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: _FloppyDiskConstants.smallSquareBorderWidth,
          ),
        ),
      ),
    );
  }
}
