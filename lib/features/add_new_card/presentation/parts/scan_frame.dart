part of '../add_card_sheet.dart';

class _ScanFrame extends StatelessWidget {
  const _ScanFrame({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Stack(
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
          ),
        ),
      ),
    );
  }
}
