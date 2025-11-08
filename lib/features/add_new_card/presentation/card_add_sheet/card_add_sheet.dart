import 'dart:async' show Completer;

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/helpers/converter/text_field_validator/text_field_validator.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:card_holder/common/presentation/widgets/buttons/default_button.dart';
import 'package:card_holder/common/presentation/widgets/color_mark/color_mark_widget.dart';
import 'package:card_holder/common/presentation/widgets/color_wheel/color_wheel_widget.dart';
import 'package:card_holder/common/presentation/widgets/containers/frame_container.dart';
import 'package:card_holder/common/presentation/widgets/logo_svg/logo_svg.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/common/presentation/widgets/text_fields/frame_text_field.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:card_holder/features/add_new_card/bloc/add_card_bloc.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'parts/entered_code.dart';
part 'parts/scan_frame.dart';

class AddCardSheet extends StatefulWidget {
  const AddCardSheet({super.key});

  static void show(BuildContext context, CreateCardBloc bloc) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BlocProvider.value(value: bloc, child: AddCardSheet());
      },
    );
  }

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  late final CreateCardBloc createBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    createBloc = context.read<CreateCardBloc>();
  }

  Future<void> onAdd() async {
    if (_formKey.currentState!.validate()) {
      final completer = Completer<DataBaseCard>();
      final createState = createBloc.state;

      final code =
          createState.detectedCode.isNotEmpty
              ? createState.detectedCode
              : createState.code;

      context.read<CardsBloc>().add(
        CardsAddCardEvent(
          urlPath: createState.urlPath,
          color: createState.color,
          code: code,
          name: createState.name,
          logoSize: createState.logoSize,
          completer: completer,
        ),
      );

      completer.future.then(
        (_) => Navigator.popUntil(context, (route) => route.isFirst),
      );
    }
  }

  void onChangeColor(Color color) =>
      createBloc.add(CreateCardChangeColorEvent(color.toARGB32()));

  void onTapColorWidget() => createBloc.add(CreateCardChangeMarkTapEvent());

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.52,
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
              onPressed: () => createBloc.add(CreateCardResumeCameraEvent()),
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
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
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
                            testKey: const Key('card_code_field'),
                            autovalidateMode: null,
                            validator: (val) {
                              return createBloc.state.code.isNotEmpty ||
                                      createBloc.state.detectedCode.isNotEmpty
                                  ? null
                                  : t.screen.home.addCard.fieldCannotBeEmpty;
                            },

                            numericKeyboard: true,
                            onChanged:
                                (v) => createBloc.add(
                                  CreateCardChangeCodeEvent(v),
                                ),
                            hintText: t.screen.home.addCard.code,
                            labelText: t.screen.home.addCard.manualCode,
                          ),
                          FrameTextField(
                            testKey: const Key('card_name_field'),
                            initText:
                                createBloc.state.name.isNotEmpty &&
                                        createBloc.state.urlPath.isNotEmpty
                                    ? createBloc.state.name
                                    : null,
                            validator:
                                context.read<TextValidatorService>().emptyCheck,
                            onChanged:
                                (v) => createBloc.add(
                                  CreateCardChangeNameEvent(v),
                                ),
                            hintText: t.screen.home.addCard.name,
                            labelText: t.screen.home.addCard.cardName,
                          ),
                          9.h,
                          DefaultButton(
                            key: const Key('create_card_button'),
                            text: t.screen.home.addCard.add,
                            onTap: onAdd,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (createBloc.state.urlPath.isNotEmpty)
                    Align(
                      alignment: const Alignment(1, -0.9),
                      child: LogoSvg(
                        logoSize: createBloc.state.logoSize,
                        urlPath: createBloc.state.urlPath,
                        cardName: createBloc.state.name,
                      ),
                    ),
                  if (createBloc.state.urlPath.isEmpty)
                    BlocBuilder<CreateCardBloc, CreateCardState>(
                      buildWhen:
                          (previous, current) =>
                              previous.color != current.color,
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
    return BlocConsumer<CreateCardBloc, CreateCardState>(
      listenWhen: (prev, curr) => prev.detectedCode != curr.detectedCode,
      listener: (context, state) {
        if (createBloc.cameraControllerSubscription.isPaused) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            createBloc.cameraController.stop();
          });
        }
        if (state.detectedCode.isNotEmpty) {
          createBloc.add(CreateCardChangeCodeEvent(state.detectedCode));
        }
      },
      builder: (context, state) {
        if (createBloc.cameraControllerSubscription.isPaused) {
          return Container(
            decoration: roundUpCornersDecoration.copyWith(
              color: AppColors.subGrey.withValues(alpha: 0.8),
            ),

            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                t.screen.home.addCard.tapToContinue,
                style: const TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  static const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );
}
