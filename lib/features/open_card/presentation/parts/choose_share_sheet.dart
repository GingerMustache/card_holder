part of '../card_open_sheet.dart';

class ChooseShareSheet extends StatefulWidget {
  const ChooseShareSheet({
    super.key,
    required this.openBloc,
    required this.barcodeKey,
    required this.card,
  });
  final OpenCardBloc openBloc;
  final GlobalKey barcodeKey; // Key
  final DataBaseCard card;

  static void show(
    BuildContext context,
    OpenCardBloc openBloc,
    GlobalKey barcodeKey,
    DataBaseCard card,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return ChooseShareSheet(
          openBloc: openBloc,
          barcodeKey: barcodeKey,
          card: card,
        );
      },
    );
  }

  @override
  State<ChooseShareSheet> createState() => _ChooseShareSheetState();
}

class _ChooseShareSheetState extends State<ChooseShareSheet> {
  void onTapFile() async =>
      context.read<CardsBloc>().add(CardsShareFileEvent());
  // get current path

  void onTapImage() => context.read<CardsBloc>().add(
    CardsShareImageEvent(barcodeKey: widget.barcodeKey),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.pop(context),
              child: const SizedBox.expand(),
            ),
          ),

          Container(
            decoration: roundUpCornersDecoration,
            width: context.halfWidth,
            padding: const EdgeInsets.only(top: 10),
            height: 150,
            child: Column(
              children: [
                Text(
                  t.screen.home.openCard.share,
                ).animate().fadeIn(duration: 550.ms),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(color: AppColors.subGrey.withAlpha(50)),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ShareCase(
                      title: t.screen.home.openCard.file,
                      onTap: onTapFile,
                    ),
                    _VerticalDivider(),
                    _ShareCase(
                      title: t.screen.home.openCard.image,
                      onTap: onTapImage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 2,
      height: 90,
      color: AppColors.subGrey.withAlpha(50),
    );
  }
}

class _ShareCase extends StatelessWidget {
  const _ShareCase({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 90,
          width: double.infinity,
          child: Center(child: Text(title, textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}
