part of "app_settings.dart";

BoxDecoration mainBoxDecoration(BuildContext context) => BoxDecoration(
  color: context.color.primary,
  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
  boxShadow: mainBoxShadow,
);
