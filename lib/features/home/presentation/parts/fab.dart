part of '../screens/home_screen.dart';

class _Fab extends StatelessWidget {
  const _Fab();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 55,

      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGrey.withValues(alpha: 0.12),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextButton(
        child: Text(t.screen.home.add, style: context.textStyles.labelSmall),
        onPressed: () => CreateCardScreen.show(context),
      ),
    );
  }
}
