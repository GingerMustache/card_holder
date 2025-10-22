part of '../../../card_open_sheet.dart';

class _PickTimeText extends StatelessWidget {
  const _PickTimeText({required this.pickTime});

  final int pickTime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$pickTime ${t.screen.home.openCard.uses}',
          style: context.textStyles.labelSmall?.copyWith(
            color: AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
