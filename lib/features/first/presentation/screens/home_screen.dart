import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/presentation/assets_parts/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            floating: true,
            toolbarHeight: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: InputSearch(
                change: (String? value) {
                  print('Search value changed: $value');
                },
                clear: () {
                  print('Search cleared');
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverAlignedGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: 100,
              itemBuilder:
                  (context, index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.mainGray,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        child: Text(
                          'Item ${index + 1}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainGray,
        borderRadius: BorderRadius.circular(8),
      ),

      margin: EdgeInsets.symmetric(horizontal: 16),

      child: TextFormField(
        controller: widget.controller,
        cursorColor: AppColors.subGrey,
        cursorWidth: 1,
        cursorHeight: 15,
        initialValue: widget.value,
        focusNode: widget.focusNode,
        textCapitalization: TextCapitalization.characters,
        style: TextStyle(fontSize: widget.fontSize, color: AppColors.subGrey),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          isCollapsed: true,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 8,
          ),
          prefix: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              SvgPicture.asset(AppIcons.find, width: 15, height: 15),
              SizedBox(width: 8),
            ],
          ),
        ),
        inputFormatters: [RemoveEmojiInputFormatter()],
        onChanged: (String val) {
          if (widget.change != null) {
            widget.change!(val);
          }
        },
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
