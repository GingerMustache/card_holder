import 'dart:async' show Completer;

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:card_holder/common/presentation/widgets/buttons/default_button.dart';
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
  const CreateCardScreen(this.cardsBloc, {super.key});
  final CardsBloc cardsBloc;

  static void show(BuildContext context, CardsBloc cardsBloc) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => CreateCardBloc(),
          child: CreateCardScreen(cardsBloc),
        );
      },
    );
  }

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  late final CreateCardBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<CreateCardBloc>();
  }

  Widget onOverlayBuilder(BuildContext context, BoxConstraints constraints) {
    if (bloc.cameraControllerSubscription.isPaused) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        bloc.cameraController.stop();
      });
      return const Text(
        'Нажмите чтобы продолжить',
        style: TextStyle(color: Colors.black),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      height: 640,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.9,
              child: ClipRRect(
                borderRadius: borderRadius,
                child: MobileScanner(
                  controller: bloc.cameraController,
                  onDetect:
                      (barcodes) => bloc.add(CreateCardSearchEvent(barcodes)),
                  overlayBuilder: onOverlayBuilder,
                ),
              ),
            ),
            _ScanFrame(
              onPressed: () {
                bloc.cameraControllerSubscription.resume();
                bloc.cameraController.start();
              },
            ),
          ],
        ),
        Expanded(
          child: ColoredBox(
            color: AppColors.mainWhite,
            child: Padding(
              padding: mainHorizontalPadding,
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
                    numericKeyboard: true,
                    onChanged: (v) => bloc.add(CreateCardChangeCodeEvent(v)),
                    hintText: t.screen.home.addCard.code,
                    labelText: t.screen.home.addCard.manualCode,
                  ),
                  FrameTextField(
                    onChanged: (v) => bloc.add(CreateCardChangeNameEvent(v)),
                    hintText: t.screen.home.addCard.name,
                    labelText: t.screen.home.addCard.cardName,
                  ),
                  20.h,
                  DefaultButton(
                    text: t.screen.home.addCard.add,
                    onTap: () async {
                      final completer = Completer<DataBaseCard>();
                      final code =
                          bloc.state.detectedCode.isNotEmpty
                              ? bloc.state.detectedCode
                              : bloc.state.code;

                      widget.cardsBloc.add(
                        CardsAddCardEvent(
                          code: code,
                          name: bloc.state.name,
                          completer: completer,
                        ),
                      );
                      try {
                        await completer.future;
                        context.pop();
                      } catch (e) {
                        // add snack
                      }
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

  static const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );
}
