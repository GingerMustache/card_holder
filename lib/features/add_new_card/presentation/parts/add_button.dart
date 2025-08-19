part of '../add_card_sheet.dart';

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
