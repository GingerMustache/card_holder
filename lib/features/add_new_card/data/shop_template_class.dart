part of '../presentation/template_card_sheet/template_card_sheet.dart';

enum TemplateStyle { disked, loading, none }

class ShopTemplate {
  final String name; // Keep name for accessibility or alt text
  final String svgUrl;
  final Color? cardColor;
  final TemplateStyle style;
  final double logoSize;

  ShopTemplate({
    this.style = TemplateStyle.none,
    this.logoSize = 30,

    required this.name,
    required this.svgUrl,
    required this.cardColor,
  });
}
