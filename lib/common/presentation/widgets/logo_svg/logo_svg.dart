import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoSvg extends StatelessWidget {
  const LogoSvg({super.key, required this.card});

  final DataBaseCard? card;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      card?.urlPath ?? '',
      height: card!.logoSize,
      width: card!.logoSize,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => _LogoText(card: card),
    );
  }
}

class _LogoText extends StatelessWidget {
  const _LogoText({required this.card});

  final DataBaseCard? card;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      card?.name ?? '',
      textAlign: TextAlign.center,
      style: context.textStyles.bodySmall,
    );
  }
}
