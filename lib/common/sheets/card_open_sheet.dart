import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/buttons/default_button.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/common/presentation/widgets/text_fields/frame_text_field.dart';
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
        return SizedBox(child: CardOpenSheet(code: code));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      height: 670,
      children: [
        Expanded(
          child: Container(
            decoration: boxDecoration,
            width: double.infinity,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.15,
                  child: ClipRRect(
                    borderRadius: allBorderRadius,
                    child: Stack(
                      children: [
                        Container(
                          color: AppColors.subGrey.withAlpha(50),
                          padding: EdgeInsets.all(35),
                          child: Container(
                            decoration: boxDecoration.copyWith(
                              color: AppColors.mainWhite,
                              borderRadius: allBorderRadius,
                            ),
                            child: Center(child: Text(code)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              t.screen.home.openCard.uses,
                              style: context.textStyles.labelSmall?.copyWith(
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: mainHorizontalPadding,
                  child: Column(
                    children: [
                      Divider(color: AppColors.subGrey.withAlpha(50)),
                      FrameTextField(
                        numericKeyboard: true,
                        onChanged: (v) => {},
                        hintText: t.screen.home.addCard.code,
                        labelText: t.screen.home.addCard.manualCode,
                      ),
                      FrameTextField(
                        onChanged: (v) => {},
                        hintText: t.screen.home.addCard.name,
                        labelText: t.screen.home.addCard.cardName,
                      ),
                      20.h,
                      Row(
                        children: [
                          Expanded(
                            child: DefaultButton(
                              text: t.screen.home.openCard.edit,
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: DefaultButton(
                              text: t.screen.home.openCard.share,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
