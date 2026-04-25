import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:url_launcher/url_launcher.dart';

class FromDeveloperSheet extends StatefulWidget {
  const FromDeveloperSheet({super.key});

  static Widget show(BuildContext context, FlipCardController controller) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        useRootNavigator: true,
        builder: (_) => FromDeveloperSheet(),
      ).then((_) => controller.flipcard()),
    );

    return Center(
      child: Text(
        t.fromDeveloper.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  State<FromDeveloperSheet> createState() => _FromDeveloperSheetState();
}

class _FromDeveloperSheetState extends State<FromDeveloperSheet> {
  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      children: [
        Expanded(
          child: Container(
            decoration: roundUpCornersDecoration(context),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: context.textStyles.labelSmall,
                      children: [
                        TextSpan(text: "${t.fromDeveloper.greeting}\n\n"),
                        TextSpan(text: "${t.fromDeveloper.intro}\n\n"),
                        TextSpan(text: "${t.fromDeveloper.freeOpenSource}\n\n"),
                        TextSpan(text: "${t.fromDeveloper.sourceCode}\n"),
                        TextSpan(
                          text: "${t.fromDeveloper.sourceCodeLink}\n\n",
                          style: TextStyle(color: AppColors.blue700),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => _openLink(
                                      t.fromDeveloper.sourceCodeLink,
                                    ),
                        ),
                        TextSpan(text: "${t.fromDeveloper.feedback}\n\n"),
                        TextSpan(text: "${t.fromDeveloper.questions}\n"),
                      ],
                    ),
                  ),

                  const Divider(color: AppColors.mainWhite),
                  20.h,

                  RichText(
                    text: TextSpan(
                      style: context.textStyles.labelSmall,
                      children: [
                        TextSpan(text: "${t.fromDeveloper.instruction}\n\n"),
                        TextSpan(text: "${t.fromDeveloper.addCardTitle}\n\n"),
                        TextSpan(
                          text: "${t.fromDeveloper.addCardDescription1}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.addCardDescription2}\n\n",
                        ),
                        TextSpan(text: "${t.fromDeveloper.addCardOption1}\n"),
                        TextSpan(text: "${t.fromDeveloper.addCardOption2}\n"),
                        TextSpan(text: "${t.fromDeveloper.addCardOption3}\n\n"),
                        TextSpan(
                          text: "${t.fromDeveloper.addCardDescription3}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.addCardDescription4}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.shareCardsTitle}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.shareCardsDescription1}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.shareCardsDescription2}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.shareCardsDescription3}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.shareCardsDescription4}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.settingsSectionTitle}\n\n",
                        ),
                        TextSpan(
                          text:
                              "${t.fromDeveloper.settingsSectionDescription1}\n\n",
                        ),
                        TextSpan(
                          text:
                              "${t.fromDeveloper.settingsSectionDescription2}\n\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.settingsSectionOption1}\n",
                        ),
                        TextSpan(
                          text: "${t.fromDeveloper.settingsSectionOption2}\n\n",
                        ),
                        TextSpan(
                          text:
                              "${t.fromDeveloper.settingsSectionDescription3}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );
}
