part of '../add_card_sheet.dart';

class _TextField extends StatelessWidget {
  const _TextField({
    required this.hintText,
    required this.labelText,
    required this.onChanged,
    this.numericKeyboard = false,
  });

  final String hintText;
  final String labelText;
  final void Function(String)? onChanged;
  final bool numericKeyboard;

  static const outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
    borderSide: BorderSide(color: AppColors.steam),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.h,
        Text(labelText, style: context.textStyles.labelSmall),
        5.h,
        TextFormField(
          keyboardType:
              numericKeyboard
                  ? TextInputType.numberWithOptions()
                  : TextInputType.multiline,
          cursorColor: AppColors.darkGrey,
          cursorWidth: 1,
          cursorHeight: 15,

          // initialValue: widget.value,
          // focusNode: widget.focusNode,
          style: TextStyle(fontSize: 16, color: AppColors.subGrey),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.subGrey),
            border: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
          ),
          inputFormatters: [RemoveEmojiInputFormatter()],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
