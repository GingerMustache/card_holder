import 'dart:async' show Completer;

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:card_holder/common/presentation/widgets/buttons/default_button.dart';
import 'package:card_holder/common/presentation/widgets/color_mark/color_mark_widget.dart';
import 'package:card_holder/common/presentation/widgets/color_wheel/color_wheel_widget.dart';
import 'package:card_holder/common/presentation/widgets/containers/frame_container.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/common/presentation/widgets/text_fields/frame_text_field.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/features/add_new_card/bloc/create_card_bloc.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'parts/entered_code.dart';
part 'parts/scan_frame.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create:
              (context) => CreateCardBloc()..add(CreateCardSetInitColorEvent()),
          child: CreateCardScreen(),
        );
      },
    );
  }

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  late final CreateCardBloc createBloc;

  @override
  void initState() {
    super.initState();
    createBloc = context.read<CreateCardBloc>();
  }

  Future<void> onAdd() async {
    final completer = Completer<DataBaseCard>();
    final createState = createBloc.state;

    final code =
        createState.detectedCode.isNotEmpty
            ? createState.detectedCode
            : createState.code;

    context.read<CardsBloc>().add(
      CardsAddCardEvent(
        color: createState.color,
        code: code,
        name: createState.name,
        completer: completer,
      ),
    );

    completer.future.then((_) => context.pop());
  }

  void onChangeColor(Color color) =>
      createBloc.add(CreateCardChangeColorEvent(color.toARGB32()));

  void onTapColorWidget() => createBloc.add(CreateCardChangeMarkTapEvent());

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      height: 640,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.7,
              child: ClipRRect(
                borderRadius: borderRadius,
                child: MobileScanner(
                  controller: createBloc.cameraController,
                  onDetect:
                      (barcodes) =>
                          createBloc.add(CreateCardSearchEvent(barcodes)),
                  overlayBuilder: onOverlayBuilder,
                ),
              ),
            ),
            _ScanFrame(
              onPressed: () {
                createBloc.cameraControllerSubscription.resume();
                createBloc.cameraController.start();
              },
            ),
          ],
        ),
        Expanded(
          child: ColoredBox(
            color: AppColors.mainWhite,
            child: Padding(
              padding: mainHorizontalPadding,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      3.h,
                      Center(
                        child: Text(
                          t.screen.home.addCard.barcodeScan,
                          style: context.textStyles.labelSmall?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Divider(color: AppColors.subGrey.withAlpha(50)),
                      10.h,
                      Text(
                        t.screen.home.addCard.detectedCode,
                        style: context.textStyles.labelSmall,
                      ),
                      5.h,
                      _EnteredCodeWidget(),
                      FrameTextField(
                        numericKeyboard: true,
                        onChanged:
                            (v) => createBloc.add(CreateCardChangeCodeEvent(v)),
                        hintText: t.screen.home.addCard.code,
                        labelText: t.screen.home.addCard.manualCode,
                      ),
                      FrameTextField(
                        onChanged:
                            (v) => createBloc.add(CreateCardChangeNameEvent(v)),
                        hintText: t.screen.home.addCard.name,
                        labelText: t.screen.home.addCard.cardName,
                      ),
                      20.h,
                      DefaultButton(
                        text: t.screen.home.addCard.add,
                        onTap: () async => onAdd(),
                      ),
                    ],
                  ),
                  BlocBuilder<CreateCardBloc, CreateCardState>(
                    buildWhen:
                        (previous, current) => previous.color != current.color,
                    builder: (context, state) {
                      return ColorMarkWidget(
                        initColor: state.color,
                        onTap: onTapColorWidget,
                      );
                    },
                  ),
                  BlocBuilder<CreateCardBloc, CreateCardState>(
                    buildWhen:
                        (prev, cur) => prev.isMarkTapped != cur.isMarkTapped,
                    builder: (context, state) {
                      return ColorWheelWidget(
                        initialColor: state.color,
                        isShow: state.isMarkTapped,
                        onChanged: onChangeColor,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget onOverlayBuilder(BuildContext context, BoxConstraints constraints) {
    if (createBloc.cameraControllerSubscription.isPaused) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        createBloc.cameraController.stop();
      });
      return const Text(
        'Нажмите чтобы продолжить',
        style: TextStyle(color: Colors.black),
      );
    }
    return const SizedBox();
  }

  static const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );
}
