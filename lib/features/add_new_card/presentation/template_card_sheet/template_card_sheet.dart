import 'dart:async';

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/application/theme/color/theme_color.dart';
import 'package:card_holder/common/application/theme/text_style/theme_text_style.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/features/add_new_card/bloc/add_card_bloc.dart';
import 'package:card_holder/features/add_new_card/presentation/card_add_sheet/card_add_sheet.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

part '../../data/shop_template_class.dart';
part 'parts/floppy_disk_container.dart';
part 'parts/loading_container.dart';
part 'parts/shop_template_list.dart';
part 'parts/card_item.dart';

class TemplateCardSheet extends StatefulWidget {
  const TemplateCardSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: CreateCardBloc()..add(CreateCardInitEvent(_shopTemplates)),
          child: const TemplateCardSheet(),
        );
      },
    );
  }

  @override
  State<TemplateCardSheet> createState() => _TemplateCardSheetState();
}

class _TemplateCardSheetState extends State<TemplateCardSheet> {
  @override
  void initState() {
    super.initState();
  }

  onChange(String? value) =>
      context.read<CreateCardBloc>().add(CreateCardSearchTemplateEvent(value));

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      children: [
        Container(
          decoration: _boxDecoration(context),
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
          child: InputSearch(change: onChange),
        ),

        Expanded(
          child: ColoredBox(
            color: context.color.surface,
            child: BlocBuilder<CreateCardBloc, CreateCardState>(
              builder: (context, state) {
                final templates = state.getTemplates;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 13,
                    childAspectRatio: 1.5,
                  ),

                  itemCount: templates.length,
                  itemBuilder: (_, index) => _CardItem(templates[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _boxDecoration(BuildContext context) => BoxDecoration(
    color: context.color.surface,
    border: const Border(bottom: BorderSide(color: AppColors.mainWhite)),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    ),
  );
}
