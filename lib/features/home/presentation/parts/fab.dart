part of '../home_screen.dart';

class _Fab extends StatelessWidget {
  const _Fab();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 55,

      decoration: fabDecor,
      child: TextButton(
        child: Text(t.screen.home.add, style: context.textStyles.labelSmall),
        onPressed: () => TemplateCardSheet.show(context),
      ),
    );
  }
}
