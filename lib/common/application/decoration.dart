part of "app_settings.dart";

BoxDecoration mainBoxDecoration(BuildContext context) => BoxDecoration(
  color: context.color.primary,
  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
  boxShadow: mainBoxShadow,
);

final BoxDecoration dividerDecor = BoxDecoration(
  border: Border(bottom: BorderSide(color: AppColors.subGrey.withAlpha(50))),
);

final BoxDecoration fabDecor = BoxDecoration(
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
);
