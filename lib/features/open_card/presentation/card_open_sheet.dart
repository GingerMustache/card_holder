import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/buttons/default_button.dart';
import 'package:card_holder/common/presentation/widgets/color_mark/color_mark_widget.dart';
import 'package:card_holder/common/presentation/widgets/color_wheel/color_wheel_widget.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/common/presentation/widgets/text_fields/frame_text_field.dart';
import 'package:card_holder/common/services/brightness_controll/brightness_control_service.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/open_card/bloc/open_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'parts/show_barcode.dart';

class CardOpenSheet extends StatefulWidget {
  const CardOpenSheet(this.curCard, {super.key});
  final DataBaseCard curCard;

  static void show(BuildContext context, DataBaseCard curCard) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create:
              (context) => OpenCardBloc(
                brightnessService: context.read<BrightnessService>(),
              )..add(OpenCardSetCurrentCardEvent(curCard)),
          child: SizedBox(child: CardOpenSheet(curCard)),
        );
      },
    );
  }

  @override
  State<CardOpenSheet> createState() => _CardOpenSheetState();

  static const boxDecoration = BoxDecoration(
    color: AppColors.mainWhite,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    ),
  );
  static const allBorderRadius = BorderRadius.all(Radius.circular(8));
}

class _CardOpenSheetState extends State<CardOpenSheet> {
  late final OpenCardBloc openBloc;

  @override
  void initState() {
    super.initState();
    openBloc = context.read<OpenCardBloc>();
  }

  @override
  void dispose() {
    openBloc.add(OpenCardChangeBrightnessEvent(dismissSheet: true));
    super.dispose();
  }

  void onEdit(BuildContext context) {
    final completer = Completer<DataBaseCard>();

    context.read<CardsBloc>().add(
      CardsUpdateCardEvent(
        color: openBloc.state.color,
        code: openBloc.state.code,
        name: openBloc.state.name,
        completer: completer,
      ),
    );
    completer.future.then((_) => context.pop());
  }

  void onChangeColor(Color color) =>
      openBloc.add(OpenCardChangeColorEvent(color.toARGB32()));

  void onTapColorWidget() => openBloc.add(OpenCardChangeMarkTapEvent());

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      height: 670,
      children: [
        Expanded(
          child: Container(
            decoration: CardOpenSheet.boxDecoration,
            width: double.infinity,
            child: Column(
              children: [
                _ShowBarcode(
                  pickTime: widget.curCard.usagePoint,
                  allBorderRadius: CardOpenSheet.allBorderRadius,
                  boxDecoration: CardOpenSheet.boxDecoration,
                ),
                Padding(
                  padding: mainHorizontalPadding,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Divider(color: AppColors.subGrey.withAlpha(50)),
                          FrameTextField(
                            numericKeyboard: true,
                            onChanged:
                                (v) => openBloc.add(OpenCardChangeCodeEvent(v)),
                            hintText: widget.curCard.code,
                            labelText: t.screen.home.addCard.manualCode,
                          ),
                          FrameTextField(
                            onChanged:
                                (v) => openBloc.add(OpenCardChangeNameEvent(v)),
                            hintText: widget.curCard.name,
                            labelText: t.screen.home.addCard.cardName,
                          ),
                          20.h,
                          Row(
                            children: [
                              Expanded(
                                child: DefaultButton(
                                  text: t.screen.home.openCard.edit,
                                  onTap: () => onEdit(context),
                                ),
                              ),
                              Expanded(
                                child: DefaultButton(
                                  text: t.screen.home.openCard.share,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      BlocBuilder<OpenCardBloc, OpenCardState>(
                        buildWhen:
                            (previous, current) =>
                                previous.color != current.color,
                        builder: (context, state) {
                          return ColorMarkWidget(
                            alignment: Alignment(0.9, 0.13),
                            initColor: state.color,
                            onTap: onTapColorWidget,
                          );
                        },
                      ),
                      BlocBuilder<OpenCardBloc, OpenCardState>(
                        buildWhen:
                            (prev, cur) =>
                                prev.isMarkTapped != cur.isMarkTapped,
                        builder: (context, state) {
                          return ColorWheelWidget(
                            alignment: Alignment(0.7, 0.7),
                            initialColor: state.color,
                            isShow: state.isMarkTapped,
                            onChanged: onChangeColor,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
