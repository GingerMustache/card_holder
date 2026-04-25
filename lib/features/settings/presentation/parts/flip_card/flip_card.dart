part of '../../screens/settings_screen.dart';

class _FlipCard extends StatefulWidget {
  const _FlipCard(this.index, {required this.title});
  final String title;
  final int index;

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> {
  late final FlipCardController controller;

  @override
  void initState() {
    super.initState();

    controller = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: controller,
      rotateSide: RotateSide.left,
      animationDuration: Duration(milliseconds: 400),
      onTapFlipping: true,
      frontWidget: _CardTemplate(
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backWidget: _CardTemplate(
        child: _UnderCardWidget(index: widget.index, controller: controller),
      ),
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
        color: context.color.onSecondary,
        borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
        boxShadow: [
          BoxShadow(
            color: context.color.surfaceTint.withValues(alpha: 0.2),
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
  const _UnderCardWidget({required this.index, required this.controller});
  final int index;
  final FlipCardController controller;

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const _ChooseTheme(),
      1 => const _ChooseLang(),
      2 => const _ChooseBrightness(),
      3 => const _Share(),
      4 => FromDeveloperSheet.show(context, controller),
      5 => const Text('5'),
      6 => const Text('6'),
      7 => const Text('7'),
      8 => const Text('8'),
      _ => const Text('Unknown Setting'),
    };
  }
}
