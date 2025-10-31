import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoSvg extends StatelessWidget {
  const LogoSvg({super.key, this.urlPath, this.cardName, this.logoSize = 30});

  final String? urlPath;
  final String? cardName;
  final double? logoSize;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      urlPath ?? '',
      height: logoSize,
      width: logoSize,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => _LogoText(cardName),
    );
  }
}

class _LogoText extends StatelessWidget {
  const _LogoText(this.cardName);

  final String? cardName;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      cardName ?? '',
      textAlign: TextAlign.center,
      style: context.textStyles.bodySmall,
    );
  }
}
