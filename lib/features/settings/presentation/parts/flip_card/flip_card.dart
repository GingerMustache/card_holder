part of '../../screens/settings_screen.dart';

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
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
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
      0 => const _ChooseTheme(),
      1 => const _ChooseLang(),
      2 => const _ChooseBrightness(),
      3 => const _Share(),
      4 => const Text('4'),
      5 => const Text('5'),
      6 => const Text('6'),
      7 => const Text('7'),
      8 => const Text('8'),
      _ => const Text('Unknown Setting'),
    };
  }
}

class _Share extends StatelessWidget {
  const _Share();
  void _onShareAllCards(BuildContext context) async {
    context.read<CardsBloc>().add(CardsShareAllCardsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen:
          (previous, current) =>
              previous.theme != current.theme || previous.lang != current.lang,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _CardTab(tabName: t.system.share.app, onTap: () => ()),
            _CardTab(
              tabName: t.system.share.cards,
              onTap: () => _onShareAllCards(context),
            ),
          ],
        );
      },
    );
  }
}
