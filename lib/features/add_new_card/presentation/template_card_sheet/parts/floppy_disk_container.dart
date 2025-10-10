part of '../template_card_sheet.dart';

class FloppyDiskContainer extends StatelessWidget {
  final double size;

  const FloppyDiskContainer({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(size * 0.05),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          // Gray top section
          Positioned(
            top: 0,
            left: size * 0.13,
            right: size * 0.23,
            child: Container(
              height: size * 0.25,

              decoration: BoxDecoration(
                color: Colors.grey[500],
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          // Slider outline on gray top
          Positioned(
            top: size * 0.02,
            left: size * 0.2,
            child: Container(
              width: size * 0.1,
              height: size * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Container(color: Colors.blue[700]),
            ),
          ),
          // right blue square
          Positioned(
            top: size * 0,
            right: size * 0.135,
            child: Container(
              width: size * 0.1,
              height: size * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Container(color: Colors.blue[700]),
            ),
          ),
          // White label area
          Positioned(
            bottom: size * 0.05,
            left: size * 0.17,
            right: size * 0.17,
            child: Container(
              height: size * 0.22,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    2,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(vertical: size * 0.01),
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'from file',
                    style: context.textStyles.titleSmall?.copyWith(
                      fontSize: 11,
                    ),
                  ),
                  ...List.generate(
                    2,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(vertical: size * 0.01),
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom left small square
          Positioned(
            bottom: size * 0.02,
            left: size * 0.05,
            child: Container(
              width: size * 0.05,
              height: size * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
          ),
          // Bottom right small square
          Positioned(
            bottom: size * 0.02,
            right: size * 0.05,
            child: Container(
              width: size * 0.05,
              height: size * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
