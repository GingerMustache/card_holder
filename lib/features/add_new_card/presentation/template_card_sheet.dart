// ignore_for_file: use_build_context_synchronously

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/features/add_new_card/bloc/add_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        Expanded(
          child: Container(
            color: AppColors.mainGray,
            child: GridView.builder(
              padding: mainPadding,
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
              itemBuilder: (_, index) => _CardItem(index),
            ),
          ),
        ),
      ],
    );
  }

  static const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );
}

class _CardItem extends StatelessWidget {
  const _CardItem(this.currentIndex);

  final int currentIndex;

  // item container
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mainBoxDecoration(context),
      child: TextButton(
        onPressed: () => {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Center(
          child: Text(
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            'data',
            textAlign: TextAlign.center,
            style: context.textStyles.bodySmall,
          ),
        ),
      ),
    );
  }
}
