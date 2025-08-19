import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:flutter/material.dart';

class CardOpenSheet extends StatelessWidget {
  const CardOpenSheet({super.key, required this.code});
  final String code;

  static void show(BuildContext context, String code) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return CardOpenSheet(code: code);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      children: [
        Expanded(
          child: Container(
            decoration: boxDecoration,
            width: double.infinity,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.4,
                  child: ClipRRect(
                    borderRadius: allBorderRadius,
                    child: Stack(
                      children: [
                        Container(
                          color: AppColors.subGrey.withAlpha(50),
                          padding: EdgeInsets.all(35),
                          child: Expanded(
                            child: Container(
                              decoration: boxDecoration.copyWith(
                                color: AppColors.mainWhite,
                                borderRadius: allBorderRadius,
                              ),
                              child: Center(child: Text(code)),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          right: 10,
                          child: Text('5 uses in this month'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: mainHorizontalPadding),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const boxDecoration = BoxDecoration(
    color: AppColors.mainWhite,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    ),
  );
  static const allBorderRadius = BorderRadius.all(Radius.circular(8));
}
