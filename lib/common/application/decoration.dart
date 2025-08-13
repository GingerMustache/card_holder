part of "app_settings.dart";

BoxDecoration mainBoxDecoration(BuildContext context) => BoxDecoration(
  color: context.color.primary,
  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
  boxShadow: mainBoxShadow,
);

final BoxDecoration dividerDecor = BoxDecoration(
  border: Border(bottom: BorderSide(color: AppColors.subGrey.withAlpha(50))),
);
