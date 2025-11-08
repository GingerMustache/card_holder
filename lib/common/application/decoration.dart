part of "app_settings.dart";

BoxDecoration mainBoxDecoration() => BoxDecoration(
  color: AppColors.mainGray,
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
      color: AppColors.darkGrey.withValues(alpha: 0.3),
      spreadRadius: 1,
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ],
);

const BoxDecoration roundUpCornersDecoration = BoxDecoration(
  color: AppColors.mainWhite,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(8.0),
    topRight: Radius.circular(8.0),
  ),
);

const BoxDecoration roundCornersDecoration = BoxDecoration(
  color: AppColors.mainWhite,
  borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
);
