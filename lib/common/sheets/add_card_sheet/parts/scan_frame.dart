part of '../add_card_sheet.dart';

class _ScanFrame extends StatelessWidget {
  const _ScanFrame();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AppIcons.barcode,
          height: 300,
          colorFilter: ColorFilter.mode(
            AppColors.mainWhite.withValues(alpha: 0.5),
            BlendMode.srcIn,
          ),
        ),
        Center(
          child: Text(
            '||||||',
            style: TextStyle(
              fontSize: 60,
              color: AppColors.mainWhite.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
