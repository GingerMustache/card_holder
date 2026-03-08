part of "app_settings.dart";

BoxDecoration mainBoxDecoration(BuildContext context) => BoxDecoration(
  color: context.color.primary,
  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
  boxShadow: mainBoxShadow,
);

BoxDecoration dividerDecor(BuildContext context) => BoxDecoration(
  border: Border(
    bottom: BorderSide(color: context.color.onSurface.withAlpha(50)),
  ),
);

BoxDecoration fabDecor(BuildContext context) => BoxDecoration(
  color: context.color.onSecondary,
  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
  boxShadow: [
    BoxShadow(
      color: AppColors.darkGrey.withValues(alpha: 0.3),
      spreadRadius: 1,
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ],
);

BoxDecoration roundUpCornersDecoration(BuildContext context) => BoxDecoration(
  color: context.color.onSecondary,
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(8.0),
    topRight: Radius.circular(8.0),
  ),
);

BoxDecoration roundCornersDecoration(BuildContext context) => BoxDecoration(
  color: context.color.onSecondary,
  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
);
