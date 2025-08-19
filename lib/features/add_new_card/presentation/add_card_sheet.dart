import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/features/add_new_card/bloc/add_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'parts/entered_code.dart';
part 'parts/scan_frame.dart';
part 'parts/text_field.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => AddCardBloc(),
          child: AddCardScreen(),
        );
      },
    );
  }

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late final AddCardBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<AddCardBloc>();
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
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.9,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: MobileScanner(
                  controller: bloc.cameraController,
                  onDetect:
                      (barcodes) => bloc.add(AddCardSearchEvent(barcodes)),
                  overlayBuilder: onOverlayBuilder,
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    bloc.cameraControllerSubscription.resume();
                    bloc.cameraController.start();
                  },
                  child: _ScanFrame(),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
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
                  _TextField(
                    numericKeyboard: true,
                    onChanged: (v) => bloc.add(AddCardChangeCodeEvent(v)),
                    hintText: t.screen.home.addCard.code,
                    labelText: t.screen.home.addCard.manualCode,
                  ),
                  _TextField(
                    onChanged: (v) => bloc.add(AddCardChangeNameEvent(v)),
                    hintText: t.screen.home.addCard.name,
                    labelText: t.screen.home.addCard.cardName,
                  ),
                  20.h,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 16,
                    ),
                    color: AppColors.mainWhite,

                    child: Center(child: Text(t.screen.home.addCard.add)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
