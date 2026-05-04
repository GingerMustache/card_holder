part of '../template_card_sheet.dart';

class _CardItem extends StatelessWidget {
  const _CardItem(this.template);

  final ShopTemplate template;

  int? get getCardColor => (template.cardColor ?? AppColors.mainRed).toARGB32();

  void onPressed(BuildContext ctx) {
    final completer = Completer();

    final bloc = ctx.read<CreateCardBloc>();
    bloc.add(
      CreateCardSetInitTemplateEvent(
        completer: completer,
        cardColor: getCardColor,
        cardName: template.name,
        svgUrl: template.svgUrl,
        logoSize: template.logoSize,
      ),
    );
    completer.future.then((_) => AddCardSheet.show(ctx, bloc));
  }

  @override
  Widget build(BuildContext context) {
    return switch (template.style) {
      TemplateStyle.disked => FloppyDiskContainer(),
      TemplateStyle.loading => LoadingContainer(),
      TemplateStyle.none => Container(
        key: Key('template_${template.name}'),
        decoration: _cardDecor,
        child: TextButton(
          onPressed: () => onPressed(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Center(
            child:
                template.svgUrl.isNotEmpty
                    ? SvgPicture.asset(
                      template.svgUrl,
                      height: template.logoSize,
                      width: template.logoSize,
                      fit: BoxFit.contain,
                      placeholderBuilder: (_) => Text(template.name),
                    )
                    : Text(
                      template.name,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.textStyles.bodySmall,
                    ),
          ),
        ),
      ),
    };
  }

  BoxDecoration get _cardDecor => BoxDecoration(
    color: template.cardColor ?? AppColors.mainGray,
    borderRadius: BorderRadius.circular(8),
  );
}
