part of '../template_card_sheet.dart';

final List<ShopTemplate> _shopTemplates = [
  ShopTemplate(
    name: 'from scratch',
    svgUrl: '',
    cardColor: AppColors.mainGray, // Green
  ),
  ShopTemplate(
    name: 'from file',
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
    name: 'spar',
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
    logoSize: 60,
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
    svgUrl:
        'https://upload.wikimedia.org/wikipedia/commons/3/3a/New_logo_of_Lenta.svg',
    cardColor: const Color(0xFFFFD700), // Yellow
  ),
  ShopTemplate(
    name: 'Ашан',
    svgUrl: 'https://en.wikipedia.org/wiki/Auchan#/media/File:Logo_Auchan.svg',
    cardColor: AppColors.darkGrey,
  ),
  ShopTemplate(
    name: 'Metro',
    svgUrl:
        'https://en.wikipedia.org/wiki/Metro_AG#/media/File:Metro_Wholesale_&_Food_Specialist_logo.svg',
    cardColor: const Color(0xFF003366), // Dark Blue
  ),
  ShopTemplate(
    name: 'О’Кей',
    svgUrl:
        '', // No public SVG found; you may need to convert a PNG to SVG or use a placeholder. Alternatively, use a PNG with Image.network.
    cardColor: const Color(0xFF008000), // Green
  ),
  ShopTemplate(
    name: 'ВкусВилл',
    svgUrl:
        'https://upload.wikimedia.org/wikipedia/commons/4/40/Vkusvill_textlogo_2021.svg',
    cardColor: const Color(0xFF90EE90), // Light Green
  ),
];
