// ignore_for_file: use_build_context_synchronously

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/features/add_new_card/bloc/add_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TemplateCardSheet extends StatefulWidget {
  const TemplateCardSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => CreateCardBloc(),
          child: TemplateCardSheet(),
        );
      },
    );
  }

  @override
  State<TemplateCardSheet> createState() => _TemplateCardSheetState();
}

class _TemplateCardSheetState extends State<TemplateCardSheet> {
  late final CreateCardBloc createBloc;

  @override
  void initState() {
    super.initState();
    createBloc = context.read<CreateCardBloc>();
  }

  void onChangeColor(Color color) =>
      createBloc.add(CreateCardChangeColorEvent(color.toARGB32()));

  void onTapColorWidget() => createBloc.add(CreateCardChangeMarkTapEvent());

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      height: 640,
      children: [
        Container(
          decoration: roundUpCornersDecoration,
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16),

          child: InputSearch(change: (value) => ()),
        ),

        Expanded(
          child: ColoredBox(
            color: AppColors.mainWhite,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                childAspectRatio: 1.5,
              ),

              itemCount: 10,
              itemBuilder: (_, index) => _CardItem(shopTemplates[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem(this.template);

  final ShopTemplate template;

  @override
  Widget build(BuildContext context) {
    if (template.funnyStyle)
      return FloppyDiskContainer();
    else
      return Container(
        decoration: BoxDecoration(
          color: template.cardColor,
          borderRadius: BorderRadius.circular(8),
          // Adjust or remove mainBoxDecoration if needed
        ),
        child: TextButton(
          onPressed: () => {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Center(
            child:
                template.svgUrl.isNotEmpty
                    ? SvgPicture.network(
                      template.svgUrl,
                      height: 30, // Adjust size as needed
                      width: 60,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) => Text(template.name),
                    )
                    : Text(
                      template.name,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.textStyles.bodySmall,
                    ),
          ),
        ),
      );
  }
}

class ShopTemplate {
  final String name; // Keep name for accessibility or alt text
  final String svgUrl;
  final Color cardColor;
  final bool funnyStyle;

  ShopTemplate({
    this.funnyStyle = false,
    required this.name,
    required this.svgUrl,
    required this.cardColor,
  });
}

// Then, update the list with SVG URLs from reliable sources (Wikimedia Commons, which are free to use)
final List<ShopTemplate> shopTemplates = [
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
    name: 'spar',
    svgUrl:
        'https://en.wikipedia.org/wiki/Spar_(retailer)#/media/File:Spar-logo.svg',
    cardColor: const Color(0xFF008000), // Green
  ),
  ShopTemplate(
    name: 'Пятёрочка',
    svgUrl:
        'https://upload.wikimedia.org/wikipedia/ru/4/4a/Pyaterochka_2020.svg',
    cardColor: const Color(0xFF008000), // Green
  ),
  ShopTemplate(
    name: 'spar',
    svgUrl:
        'https://en.wikipedia.org/wiki/Spar_(retailer)#/media/File:Spar-logo.svg',
    cardColor: const Color(0xFF008000), // Green
  ),
  ShopTemplate(
    name: 'Магнит',
    svgUrl:
        'https://en.wikipedia.org/wiki/Magnit#/media/File:%D0%9B%D0%BE%D0%B3%D0%BE%D1%82%D0%B8%D0%BF_-_%D0%9C%D0%B0%D0%B3%D0%BD%D0%B8%D1%82.svg',
    cardColor: const Color(0xFFE60000), // Red
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
        'https://upload.wikimedia.org/wikipedia/commons/3/3e/Vkusvill_textlogo_2021.svg',
    cardColor: const Color(0xFF90EE90), // Light Green
  ),
];

class FloppyDiskContainer extends StatelessWidget {
  final double size;

  const FloppyDiskContainer({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(size * 0.05),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          // Gray top section
          Positioned(
            top: 0,
            left: size * 0.13,
            right: size * 0.23,
            child: Container(
              height: size * 0.25,

              decoration: BoxDecoration(
                color: Colors.grey[500],
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          // Slider outline on gray top
          Positioned(
            top: size * 0.02,
            left: size * 0.2,
            child: Container(
              width: size * 0.1,
              height: size * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Container(color: Colors.blue[700]),
            ),
          ),
          // right blue square
          Positioned(
            top: size * 0,
            right: size * 0.135,
            child: Container(
              width: size * 0.1,
              height: size * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Container(color: Colors.blue[700]),
            ),
          ),
          // White label area
          Positioned(
            bottom: size * 0.05,
            left: size * 0.17,
            right: size * 0.17,
            child: Container(
              height: size * 0.22,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    2,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(vertical: size * 0.01),
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'from file',
                    style: context.textStyles.titleSmall?.copyWith(
                      fontSize: 11,
                    ),
                  ),
                  ...List.generate(
                    2,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(vertical: size * 0.01),
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom left small square
          Positioned(
            bottom: size * 0.02,
            left: size * 0.05,
            child: Container(
              width: size * 0.05,
              height: size * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
          ),
          // Bottom right small square
          Positioned(
            bottom: size * 0.02,
            right: size * 0.05,
            child: Container(
              width: size * 0.05,
              height: size * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
