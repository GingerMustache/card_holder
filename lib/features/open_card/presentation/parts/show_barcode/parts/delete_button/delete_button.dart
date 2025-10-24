part of '../../../../card_open_sheet.dart';

class _DeleteButton extends StatelessWidget {
  const _DeleteButton(this.id);

  final int id;

  onDelete(BuildContext context) => _DeleteSheet.show(context, id);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'delete',
          style: context.textStyles.labelSmall?.copyWith(
            color: AppColors.mainRed,
          ),
        ),
      ).onTap(() => onDelete(context)),
    );
  }
}
