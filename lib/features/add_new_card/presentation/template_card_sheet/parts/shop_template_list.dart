part of '../template_card_sheet.dart';

final List<ShopTemplate> _shopTemplates = [
  ShopTemplate(
    name: t.shops.fromScratch,
    svgUrl: '',
    cardColor: AppColors.mainGray, // Green
  ),
  ShopTemplate(
    name: t.shops.fromFile,
    funnyStyle: true,
    svgUrl: '',
    cardColor: AppColors.mainGray, // Green
  ),

  ShopTemplate(
    name: 'Пятёрочка',
    svgUrl: AppIcons.fiveShop,
    cardColor: const Color(0xFF008000), // Green
  ),
  ShopTemplate(
    name: 'Спар',
    svgUrl: AppIcons.sparShop,
    cardColor: const Color(0xFF008000), // Green
  ),
  ShopTemplate(
    name: 'Магнит',
    svgUrl: AppIcons.magnetShop,
    cardColor: AppColors.mainGray, // Red
  ),
  ShopTemplate(
    name: 'Перекрёсток',
    svgUrl: AppIcons.perectrestokShop,
    cardColor: const Color(0xFF006400), // Dark Green
  ),
  ShopTemplate(
    name: 'Дикси',
    logoSize: 45,
    svgUrl: AppIcons.dixyShop,
    cardColor: const Color(0xFFFFA500), // Orange
  ),
  ShopTemplate(
    name: 'Красное & Белое',
    svgUrl: AppIcons.kbShop,
    cardColor: const Color(0xFFCC0000), // Red
  ),
  ShopTemplate(
    name: 'Лента',
    logoSize: 40,
    svgUrl: AppIcons.lentaShop,
    cardColor: const Color(0xFFFFD700), // Yellow
  ),
  ShopTemplate(
    name: 'Ашан',
    svgUrl: AppIcons.ashanShop,
    cardColor: AppColors.darkGrey,
  ),
  ShopTemplate(
    name: 'Metro',
    svgUrl: AppIcons.metroShop,
    cardColor: const Color(0xFF003366), // Dark Blue
  ),
  ShopTemplate(
    name: 'О’Кей',
    svgUrl: AppIcons.okShop,
    cardColor: const Color(0xFF008000), // Green
  ),
  ShopTemplate(
    name: 'ВкусВилл',
    svgUrl: AppIcons.vkusVilShop,
    cardColor: const Color(0xFF90EE90), // Light Green
  ),
  ShopTemplate(
    name: 'Спортмастер',
    logoSize: 25,
    svgUrl: AppIcons.sportmasterShop,
    cardColor: const Color(0xFF00008B), // Dark Blue (placeholder)
  ),
];
