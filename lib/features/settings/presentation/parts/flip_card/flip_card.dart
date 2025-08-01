part of '../../../../home/presentation/screens/home_screen.dart';

class _FlipCard extends StatelessWidget {
  const _FlipCard(this.index, {required this.title});
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: FlipCardController(),
      rotateSide: RotateSide.left,
      animationDuration: Duration(milliseconds: 500),
      onTapFlipping: true,
      frontWidget: _CardTemplate(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backWidget: _CardTemplate(child: _UnderCardWidget(index: index)),
    );
  }
}

class _CardTemplate extends StatelessWidget {
  const _CardTemplate({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGrey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _UnderCardWidget extends StatelessWidget {
  const _UnderCardWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const Text('0'),
      1 => const Text(' 1'),
      2 => const Text('2'),
      3 => const Text('3'),
      4 => const Text('4'),
      5 => _ChooseLang(),
      6 => const Text('6'),
      7 => const Text('7'),
      8 => const Text('8'),
      _ => const Text('Unknown Setting'),
    };
  }
}
