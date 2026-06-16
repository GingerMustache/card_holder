import 'dart:async' show Completer;

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
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
part 'parts/logo_or_color_badge.dart';
part 'parts/scan_frame.dart';

class AddCardSheet extends StatefulWidget {
  const AddCardSheet({super.key});

  static void show(BuildContext context, CreateCardBloc bloc) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder:
          (_) => BlocProvider.value(value: bloc, child: const AddCardSheet()),
    );
  }

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  late final CreateCardBloc createBloc;
  final _formKey = GlobalKey<FormState>();

  CreateCardState get state => createBloc.state;

  @override
  void initState() {
    super.initState();
    createBloc = context.read<CreateCardBloc>();
  }

  Future<void> onAdd() async {
    if (_formKey.currentState!.validate()) {
      final completer = Completer<DataBaseCard>();

      context.read<CardsBloc>().add(
        CardsAddCardEvent(
          cardCodeType: state.cardCodeType,
          urlPath: state.urlPath,
          color: state.color,
          code: state.getCode,
          name: state.name,
          logoSize: state.logoSize,
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

  void onPressedScan() => createBloc.add(CreateCardResumeCameraEvent());

  void onDetect(BarcodeCapture barcodes) =>
      createBloc.add(CreateCardSearchEvent(barcodes));

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.50,
              child: ClipRRect(
                borderRadius: borderRadius,
                child: MobileScanner(
                  controller: createBloc.cameraController,
                  overlayBuilder: onOverlayBuilder,
                  onDetect: onDetect,
                ),
              ),
            ),
            _ScanFrame(onPressed: onPressedScan),
          ],
        ),
        Expanded(
          child: ColoredBox(
            color: context.color.onSecondary,
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
                          2.h,
                          Center(
                            child: Text(
                              t.screen.home.addCard.barcodeScan,
                              style: context.textStyles.labelSmall.copyWith(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          _LogoOrColorBadge(state),
                          8.h,
                          Text(
                            t.screen.home.addCard.detectedCode,
                            style: context.textStyles.labelSmall,
                          ),
                          4.h,
                          _EnteredCodeWidget(),
                          ..._nameAndCodeFields(),
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

  List<Widget> _nameAndCodeFields() {
    codeValidator(String? val) =>
        state.codeIsNotEmpty || (val?.isNotEmpty ?? false)
            ? null
            : t.screen.home.addCard.fieldCannotBeEmpty;

    nameValidator(String? val) =>
        state.name.isNotEmpty ? null : t.screen.home.addCard.fieldCannotBeEmpty;

    void codeClear() =>
        context.read<CreateCardBloc>().add(CreateCardChangeCodeEvent(''));

    void nameClear() =>
        context.read<CreateCardBloc>().add(CreateCardChangeNameEvent(''));

    return [
      FrameTextField(
        testKey: const Key('card_code_field'),
        clear: codeClear,
        validator: codeValidator,
        numericKeyboard: true,
        onChanged: (v) => createBloc.add(CreateCardChangeCodeEvent(v)),
        hintText: t.screen.home.addCard.code,
        labelText: t.screen.home.addCard.manualCode,
      ),
      FrameTextField(
        testKey: const Key('card_name_field'),
        clear: nameClear,
        validator: nameValidator,
        onChanged: (v) => createBloc.add(CreateCardChangeNameEvent(v)),
        hintText:
            state.name.isNotEmpty && state.urlPath.isNotEmpty
                ? state.name
                : t.screen.home.addCard.name,
        labelText: t.screen.home.addCard.cardName,
      ),
    ];
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
            decoration: roundUpCornersDecoration(
              context,
            ).copyWith(color: context.color.onSurface.alpha08),

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
