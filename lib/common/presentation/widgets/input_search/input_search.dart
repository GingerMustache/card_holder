import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

class InputSearch extends StatefulWidget {
  const InputSearch({
    super.key,
    this.fontSize = 16,
    this.focusNode,
    required this.change,
    this.clear,
  });

  final double fontSize;

  final FocusNode? focusNode;
  final Function(String? value) change;
  final Function()? clear;

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void onTap() {
    controller.clear();
    widget.change('');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: mainBoxDecoration(context),

        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          controller: controller,
          cursorColor: AppColors.darkGrey,
          cursorWidth: 1,
          cursorHeight: 15,

          focusNode: widget.focusNode,
          style: TextStyle(fontSize: widget.fontSize, color: AppColors.subGrey),
          decoration: InputDecoration(
            suffix: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox();
                return InkWell(
                  splashFactory: null,
                  onTap: widget.clear ?? onTap,
                  child: Text(
                    'del',
                    style: context.textStyles.labelSmall?.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                );
              },
            ),

            hintText: t.other.search,
            hintStyle: TextStyle(color: AppColors.subGrey),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            isCollapsed: true,

            contentPadding: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 8,
            ),
            prefixIconConstraints: const BoxConstraints(
              maxWidth: 35,
              maxHeight: 35,
              minWidth: 30,
            ),
          ),
          inputFormatters: [RemoveEmojiInputFormatter()],
          onChanged: (String val) {
            controller.text = val;
            widget.change(val);
          },
        ),
      ),
    );
  }
}

class RemoveEmojiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(' ', '');
    var selection = newValue.selection;
    if (oldValue.text == text) {
      selection = oldValue.selection;
    }
    return TextEditingValue(text: text, selection: selection);
  }
}
