part of '../../../card_open_sheet.dart';

class _DeleteButton extends StatelessWidget {
  const _DeleteButton(this.id);

  final int id;

  onLightTap(BuildContext context) {
    DeleteSheet.show(context, id);
    // final completer = Completer();
    // context.read<CardsBloc>().add(
    //   CardsDeleteCardEvent(id: id, completer: completer),
    // );
    // completer.future.then((_) => context.pop());
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'delete',
          style: context.textStyles.labelSmall?.copyWith(
            color: AppColors.mainRed,
          ),
        ),
      ).onTap(() => onLightTap(context)),
    );
  }
}

class DeleteSheet extends StatefulWidget {
  const DeleteSheet(this.id, {super.key});

  final int id;

  static void show(BuildContext context, int id) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return DeleteSheet(id);
      },
    );
  }

  @override
  State<DeleteSheet> createState() => _DeleteSheetState();
}

class _DeleteSheetState extends State<DeleteSheet> {
  void onTapFile() async =>
      context.read<CardsBloc>().add(CardsShareFileEvent());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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

                _ShareCase(
                  title: t.screen.home.openCard.file,
                  onTap: onTapFile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
