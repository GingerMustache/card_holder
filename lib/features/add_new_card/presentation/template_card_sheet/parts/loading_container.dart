part of '../template_card_sheet.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PixelWord(
              text: 'LOADING...',
              pixelSize: 3,
              pixelGap: 0.6,
              charGap: 2.4,
              color: AppColors.mainBlack,
            ),
            12.h,
            _LoadingProgressBar(
              filledSteps: _LoadingConstants.staticFilledSteps,
              totalSteps: _LoadingConstants.staticTotalSteps,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingProgressBar extends StatelessWidget {
  const _LoadingProgressBar({
    required this.filledSteps,
    required this.totalSteps,
  });

  final int filledSteps;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainBlack, width: 3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        children: [
          ...List.generate(totalSteps, (index) {
            final isFilled = index < filledSteps;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.4),
                child: Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: isFilled ? AppColors.mainBlack : AppColors.mainWhite,
                    border: Border.all(color: AppColors.mainBlack, width: 1),
                  ),
                ),
              ),
            );
          }),
          2.w,
          Text(
            'из интернетов',
            style: context.textStyles.bodySmall?.copyWith(fontSize: 9),
          ),
        ],
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
  static const double pixelRadius = 1;
  static const double progressBorderWidth = 3;
  static const int staticFilledSteps = 7;
  static const int staticTotalSteps = 12;
}
