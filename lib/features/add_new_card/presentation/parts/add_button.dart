part of '../add_card_sheet.dart';

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print('Add card pressed'),
      splashColor: AppColors.mainWhite,
      splashFactory: null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        color: AppColors.mainWhite,

        child: Center(child: Text(t.screen.home.addCard.add)),
      ),
    );
  }
}
