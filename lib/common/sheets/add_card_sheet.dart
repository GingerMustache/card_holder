import 'dart:async';

import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: SizedBox(width: double.infinity, child: AddCardScreen()),
        );
      },
    );
  }

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late MobileScannerController cameraController;
  late StreamSubscription cameraControllerSubscription;
  late TextEditingController _controller;
  late FocusNode _nodeSearch;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(detectionTimeoutMs: 1500);
    _controller = TextEditingController();
    _nodeSearch = FocusNode();

    cameraControllerSubscription = cameraController.barcodes.listen(
      (event) => {},
    );
  }

  setLoading(bool value) => setState(() => loading = value);

  search(BarcodeCapture barcodes) async {
    if (!loading &&
        barcodes.barcodes.isNotEmpty &&
        barcodes.barcodes.first.rawValue != null) {
      _controller.text = barcodes.barcodes.first.rawValue!;
      await submit(context);
      cameraControllerSubscription.pause();
    }
  }

  Future<bool> submit(BuildContext context) async {
    if (_controller.text.isEmpty) {
      print('Введите штрих-код или артикул');

      return false;
    }

    // setLoading(true);
    // final int id = AppModel.instance.personalUser?.id ?? 0;
    // List<ProductModel> products = await PersonalService.searchProducts({
    //   'query_text': _controller.text,
    //   'user_id': id,
    // });
    // setLoading(false);

    // if (products.isNotEmpty) {
    //   _controller.clear();
    //   if (products.length == 1) {
    //     context.pushNamed(LeftoversConst.product, extra: products.first);
    //   } else {
    //     context.pushNamed(LeftoversConst.searchProducts, extra: products);
    //   }

    //   fetchHistory();
    // } else {
    //   AnimatedSnackBar.show('Позиция не найдена');

    //   _controller.clear();
    // }
    return true;
  }

  Widget onOverlayBuilder(BuildContext context, BoxConstraints constraints) {
    if (cameraControllerSubscription.isPaused) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        cameraController.stop();
      });
      return const Text(
        'Нажмите чтобы продолжить',
        style: TextStyle(color: Colors.black),
      );
    }
    return const SizedBox();
  }

  @override
  void dispose() {
    cameraControllerSubscription.cancel();
    cameraController.stop();
    cameraController.dispose();

    _nodeSearch.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
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
                  controller: cameraController,
                  onDetect: search,
                  overlayBuilder: onOverlayBuilder,
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    cameraControllerSubscription.resume();
                    cameraController.start();
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
                children: [
                  5.h,
                  Divider(color: AppColors.subGrey.withAlpha(50)),
                  // Text(
                  //   'Просканируйте штрих-код товара или введите код товара вручную для поиска',
                  // ),
                  40.h,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScanFrame extends StatelessWidget {
  const _ScanFrame();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AppIcons.barcode,
          height: 300,
          colorFilter: ColorFilter.mode(
            AppColors.mainWhite.withValues(alpha: 0.5),
            BlendMode.srcIn,
          ),
        ),
        Center(
          child: Text(
            '||||||',
            style: TextStyle(
              fontSize: 60,
              color: AppColors.mainWhite.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 35,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.steam.withAlpha(220),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ),
        5.h,
        ...children,
      ],
    );
  }
}

// Widget _loadingPlaceHolder(BuildContext context) {
//   return ShimmerContainer(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: AppScale.scaleHorizontally(context, 88)),
//           Text('история поиска'.toUpperCase(), style: context.regular_20),
//           SizedBox(height: AppScale.scaleHorizontally(context, 20)),
//         ],
//       ),
//     ),
//   );
// }
