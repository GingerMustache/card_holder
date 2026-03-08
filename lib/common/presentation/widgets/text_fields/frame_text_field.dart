import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/presentation/widgets/input_search/input_search.dart';
import 'package:flutter/material.dart';

class FrameTextField extends StatefulWidget {
  const FrameTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
    required this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.numericKeyboard = false,
    this.initText,
    this.testKey,
    this.clear,
  });

  final String hintText;
  final String labelText;
  final String? initText;
  final void Function(String)? onChanged;
  final bool numericKeyboard;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Key? testKey;
  final Function()? clear;

  @override
  State<FrameTextField> createState() => _FrameTextFieldState();

  static OutlineInputBorder outlineInputBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.elliptical(8, 8)),
        borderSide: BorderSide(color: context.color.outline),
      );
}

class _FrameTextFieldState extends State<FrameTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initText);
  }

  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.h,
        Text(widget.labelText, style: context.textStyles.labelSmall),
        5.h,
        TextFormField(
          controller: _controller,
          key: widget.testKey,
          initialValue: widget.initText,
          validator: widget.validator,
          keyboardType:
              widget.numericKeyboard
                  ? TextInputType.numberWithOptions()
                  : TextInputType.multiline,
          cursorColor: context.color.onSurface,
          cursorWidth: 1,
          cursorHeight: 15,
          style: context.textStyles.bodySmall,
          decoration: InputDecoration(
            suffix: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return InkWell(
                  splashFactory: null,
                  onTap: () {
                    _controller.clear();
                    widget.onChanged?.call('');
                  },
                  child: Text(
                    t.other.clear,
                    style: context.textStyles.labelSmall?.copyWith(
                      color: context.color.onSurface,
                    ),
                  ),
                );
              },
            ),

            hintText: widget.hintText,
            hintStyle: context.textStyles.bodySmall,
            border: FrameTextField.outlineInputBorder(context),
            focusedBorder: FrameTextField.outlineInputBorder(context),
            enabledBorder: FrameTextField.outlineInputBorder(context),
            errorStyle: context.textStyles.labelSmall?.copyWith(
              color: context.color.error,
              fontSize: 9.5,
              height: 0.65,
            ),
          ),
          inputFormatters: [RemoveEmojiInputFormatter()],
          autovalidateMode: widget.autovalidateMode,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
