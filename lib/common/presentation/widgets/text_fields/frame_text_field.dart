import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:flutter/material.dart';

class FrameTextField extends StatelessWidget {
  const FrameTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
    required this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.numericKeyboard = false,
    this.initText,
  });

  final String hintText;
  final String labelText;
  final String? initText;
  final void Function(String)? onChanged;
  final bool numericKeyboard;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.h,
        Text(labelText, style: context.textStyles.labelSmall),
        5.h,
        TextFormField(
          initialValue: initText,
          validator: validator,
          keyboardType:
              numericKeyboard
                  ? TextInputType.numberWithOptions()
                  : TextInputType.multiline,
          cursorColor: AppColors.darkGrey,
          cursorWidth: 1,
          cursorHeight: 15,
          style: TextStyle(fontSize: 16, color: AppColors.subGrey),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.subGrey),
            border: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorStyle: context.textStyles.labelSmall?.copyWith(
              color: AppColors.errorRed,
              fontSize: 9.5,
              height: 0.65,
            ),
          ),
          inputFormatters: [RemoveEmojiInputFormatter()],
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
        ),
      ],
    );
  }

  static const outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
    borderSide: BorderSide(color: AppColors.steam),
  );
}
