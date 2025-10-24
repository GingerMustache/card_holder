part of '../../../../card_open_sheet.dart';

class _DeleteSheet extends StatefulWidget {
  const _DeleteSheet(this.id);

  final int id;

  static void show(BuildContext context, int id) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return _DeleteSheet(id);
      },
    );
  }

  @override
  State<_DeleteSheet> createState() => _DeleteSheetState();
}

class _DeleteSheetState extends State<_DeleteSheet> {
  void onDelete() async {
    final completer = Completer();
    context.read<CardsBloc>().add(
      CardsDeleteCardEvent(id: widget.id, completer: completer),
    );
    completer.future.then(
      (_) => Navigator.popUntil(context, (route) => route.isFirst),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            width: context.halfWidth / 1.5,

            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  decoration: roundCornersDecoration,
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('delete?').animate().fadeIn(duration: 550.ms),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(color: AppColors.subGrey.withAlpha(50)),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('yes'),
                      ),
                    ],
                  ).onTap(onDelete),
                ),

                _EmptyPopSpace(),
              ],
            ),
          ),
          _EmptyPopSpace(),
        ],
      ),
    );
  }
}

class _EmptyPopSpace extends StatelessWidget {
  const _EmptyPopSpace();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: const SizedBox.expand(),
      ),
    );
  }
}
