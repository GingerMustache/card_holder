part of '../presentation/template_card_sheet/template_card_sheet.dart';

class ShopTemplate {
  final String name; // Keep name for accessibility or alt text
  final String svgUrl;
  final Color? cardColor;
  final bool funnyStyle;
  final double logoSize;

  ShopTemplate({
    this.funnyStyle = false,
    this.logoSize = 30,

    required this.name,
    required this.svgUrl,
    required this.cardColor,
  });
}
