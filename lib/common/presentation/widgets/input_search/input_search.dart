import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

class InputSearch extends StatefulWidget {
  const InputSearch({
    super.key,
    this.value,
    this.fontSize = 16,
    this.focusNode,
    this.controller,
    this.change,
    this.clear,
  });

  final String? value;
  final double fontSize;

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String? value)? change;
  final Function()? clear;

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  String? value;

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(() {
      setState(() => value = widget.controller!.text);
    });

    setState(() {
      value = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: mainBoxDecoration(context),

        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: AppColors.darkGrey,
          cursorWidth: 1,
          cursorHeight: 15,
          initialValue: widget.value,
          focusNode: widget.focusNode,

          style: TextStyle(fontSize: widget.fontSize, color: AppColors.subGrey),

          decoration: InputDecoration(
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
            // prefixIcon: SizedBox(
            //   height: 18,
            //   child: SvgPicture.asset(AppIcons.find),
            // ),
          ),
          // inputFormatters: [RemoveEmojiInputFormatter()],
          onChanged: (String val) {
            if (widget.change != null) {
              widget.change!(val);
            }
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
