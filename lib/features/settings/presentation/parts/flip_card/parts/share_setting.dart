part of '../../../screens/settings_screen.dart';

class _Share extends StatelessWidget {
  const _Share();
  void _onShareAllCards(BuildContext context) async {
    context.read<CardsBloc>().add(CardsShareAllCardsEvent(context));
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
