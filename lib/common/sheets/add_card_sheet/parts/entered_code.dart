part of '../add_card_sheet.dart';

class _EnteredCodeWidget extends StatelessWidget {
  const _EnteredCodeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.steam),

        borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
      ),
      child: Center(
        child: Text('0000 0000 0000', style: context.textStyles.displayMedium),
      ),
    );
  }
}
