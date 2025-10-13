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
    svgUrl:
        'https://upload.wikimedia.org/wikipedia/ru/d/d9/Perekryostok-logo-2014.svg',
    cardColor: const Color(0xFF006400), // Dark Green
  ),
  ShopTemplate(
    name: 'Дикси',
    svgUrl: 'https://en.wikipedia.org/wiki/Dixy#/media/File:Dixy_logo.svg',
    cardColor: const Color(0xFFFFA500), // Orange
  ),
  ShopTemplate(
    name: 'Красное & Белое',
    svgUrl:
        'https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B5_%D0%B8_%D0%91%D0%B5%D0%BB%D0%BE%D0%B5_%D0%BB%D0%BE%D0%B3%D0%BE%D1%82%D0%B8%D0%BF.svg',
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
