import 'package:barcode_widget/barcode_widget.dart';
import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/buttons/default_button.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:card_holder/common/presentation/widgets/text_fields/frame_text_field.dart';
import 'package:card_holder/features/home/bloc/cards_bloc.dart';
import 'package:card_holder/features/open_card/bloc/open_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardOpenSheet extends StatefulWidget {
  const CardOpenSheet({super.key});

  static void show(BuildContext context, CardsBloc cardsBloc) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => cardsBloc),
            BlocProvider(create: (context) => OpenCardBloc()),
          ],
          child: SizedBox(child: CardOpenSheet()),
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

  void onEdit(BuildContext context) {
    context.read<CardsBloc>().add(
      CardsUpdateCardEvent(
        code: openBloc.state.code,
        name: openBloc.state.name,
      ),
    );
  }

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
                  allBorderRadius: CardOpenSheet.allBorderRadius,
                  boxDecoration: CardOpenSheet.boxDecoration,
                ),
                Padding(
                  padding: mainHorizontalPadding,
                  child: Column(
                    children: [
                      Divider(color: AppColors.subGrey.withAlpha(50)),
                      FrameTextField(
                        numericKeyboard: true,
                        onChanged:
                            (v) => openBloc.add(OpenCardChangeCodeEvent(v)),
                        hintText: t.screen.home.addCard.code,
                        labelText: t.screen.home.addCard.manualCode,
                      ),
                      FrameTextField(
                        onChanged:
                            (v) => openBloc.add(OpenCardChangeNameEvent(v)),
                        hintText: t.screen.home.addCard.name,
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ShowBarcode extends StatelessWidget {
  const _ShowBarcode({
    required this.allBorderRadius,
    required this.boxDecoration,
  });

  final BorderRadius allBorderRadius;
  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.15,
      child: ClipRRect(
        borderRadius: allBorderRadius,
        child: Stack(
          children: [
            Container(
              color: AppColors.subGrey.withAlpha(50),
              padding: EdgeInsets.all(35),
              child: Container(
                decoration: boxDecoration.copyWith(
                  color: AppColors.mainWhite,
                  borderRadius: allBorderRadius,
                ),
                child: Center(
                  child: BlocBuilder<CardsBloc, CardsState>(
                    builder: (context, state) {
                      return BarcodeWidget(
                        barcode: Barcode.code128(),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        width: double.infinity,
                        height: 200,
                        data: state.currentCard?.code ?? '',
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  t.screen.home.openCard.uses,
                  style: context.textStyles.labelSmall?.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
