import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorMark extends StatelessWidget {
  const ColorMark(this.color, {super.key, this.needText = true});
  final int color;
  final bool needText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppIcons.bookmark,
          height: 25,
          colorFilter: ColorFilter.mode(
            Color(color).withAlpha(255),
            BlendMode.srcIn,
          ),
        ),
        if (needText)
          Text(
            t.screen.home.addCard.color,
            style: context.textStyles.labelSmall?.copyWith(
              color: Color(color).withAlpha(250),
            ),
          ),
      ],
    );
  }
}
