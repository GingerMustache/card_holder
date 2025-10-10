import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/features/add_new_card/bloc/add_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

part '../../data/shop_template_class.dart';
part 'parts/floppy_disk_container.dart';
part 'parts/shop_template_list.dart';

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
              itemBuilder: (_, index) => _CardItem(_shopTemplates[index]),
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
    return template.funnyStyle
        ? FloppyDiskContainer()
        : Container(
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
