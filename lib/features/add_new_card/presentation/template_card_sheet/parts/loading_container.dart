part of '../template_card_sheet.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size =
            constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth
                : constraints.maxHeight;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.mainWhite,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.mainBlack,
              width: _LoadingConstants.outerBorderWidth,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _LoadingConstants.horizontalPaddingRatio * size,
              vertical: _LoadingConstants.verticalPaddingRatio * size,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PixelWord(
                  text: 'LOADING...',
                  pixelSize: _LoadingConstants.pixelSizeRatio * size,
                  pixelGap: _LoadingConstants.pixelGapRatio * size,
                  charGap: _LoadingConstants.charGapRatio * size,
                  color: AppColors.mainBlack,
                ),
                SizedBox(height: _LoadingConstants.wordToBarGapRatio * size),
                _LoadingProgressBar(
                  filledSteps: _LoadingConstants.staticFilledSteps,
                  totalSteps: _LoadingConstants.staticTotalSteps,
                  size: size,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoadingProgressBar extends StatelessWidget {
  const _LoadingProgressBar({
    required this.filledSteps,
    required this.totalSteps,
    required this.size,
  });

  final int filledSteps;
  final int totalSteps;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _LoadingConstants.barHeightRatio * size,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mainBlack,
          width: _LoadingConstants.progressBorderWidth,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(_LoadingConstants.barInnerPaddingRatio * size),

        child: Row(
          children: List.generate(totalSteps, (index) {
            final isFilled = index < filledSteps;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _LoadingConstants.segmentGapRatio * size,
                ),
                child: Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: isFilled ? AppColors.mainBlack : AppColors.mainWhite,

                    border: Border.all(
                      color: AppColors.mainBlack,
                      width: _LoadingConstants.segmentBorderWidth,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _PixelWord extends StatelessWidget {
  const _PixelWord({
    required this.text,
    required this.pixelSize,
    required this.pixelGap,
    required this.charGap,
    required this.color,
  });

  final String text;
  final double pixelSize;
  final double pixelGap;
  final double charGap;
  final Color color;

  static const Map<String, List<String>> _glyphs = {
    'L': ['10000', '10000', '10000', '10000', '11111'],
    'O': ['01110', '10001', '10001', '10001', '01110'],
    'A': ['01110', '10001', '11111', '10001', '10001'],
    'D': ['11110', '10001', '10001', '10001', '11110'],
    'I': ['11111', '00100', '00100', '00100', '11111'],
    'N': ['10001', '11001', '10101', '10011', '10001'],
    'G': ['01111', '10000', '10111', '10001', '01111'],
    '.': ['00000', '00000', '00000', '00110', '00110'],
    ' ': ['000', '000', '000', '000', '000'],
  };

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: List.generate(text.length, (index) {
          final char = text[index].toUpperCase();
          final glyph = _glyphs[char] ?? _glyphs[' ']!;

          return Padding(
            padding: EdgeInsets.only(
              right: index == text.length - 1 ? 0 : charGap,
            ),
            child: _PixelGlyph(
              glyph: glyph,
              pixelSize: pixelSize,
              pixelGap: pixelGap,
              color: color,
            ),
          );
        }),
      ),
    );
  }
}

class _PixelGlyph extends StatelessWidget {
  const _PixelGlyph({
    required this.glyph,
    required this.pixelSize,
    required this.pixelGap,
    required this.color,
  });

  final List<String> glyph;
  final double pixelSize;
  final double pixelGap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(glyph.length, (row) {
        final rowPattern = glyph[row];
        return Padding(
          padding: EdgeInsets.only(
            bottom: row == glyph.length - 1 ? 0 : pixelGap,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(rowPattern.length, (column) {
              final isOn = rowPattern[column] == '1';
              return Padding(
                padding: EdgeInsets.only(
                  right: column == rowPattern.length - 1 ? 0 : pixelGap,
                ),
                child: SizedBox.square(
                  dimension: pixelSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isOn ? color : AppColors.transparent,
                      borderRadius: BorderRadius.circular(
                        _LoadingConstants.pixelRadius,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

class _LoadingConstants {
  static const double outerBorderWidth = 3;
  static const double horizontalPaddingRatio = 0.06;
  static const double verticalPaddingRatio = 0.14;
  static const double pixelSizeRatio = 0.03;
  static const double pixelGapRatio = 0.006;
  static const double charGapRatio = 0.024;
  static const double pixelRadius = 1;
  static const double wordToBarGapRatio = 0.12;
  static const double barHeightRatio = 0.28;
  static const double progressBorderWidth = 3;
  static const double barInnerPaddingRatio = 0.022;
  static const double segmentGapRatio = 0.004;
  static const double segmentBorderWidth = 1;
  static const int staticFilledSteps = 6;
  static const int staticTotalSteps = 12;
}
