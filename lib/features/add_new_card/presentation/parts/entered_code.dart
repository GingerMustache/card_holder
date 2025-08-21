part of '../add_card_sheet.dart';

class _EnteredCodeWidget extends StatelessWidget {
  const _EnteredCodeWidget();

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      child: Center(
        child: BlocBuilder<CreateCardBloc, CreateCardState>(
          buildWhen: (previous, current) => previous.code != current.code,
          builder: (context, state) {
            final code =
                state.code.isNotEmpty ? state.code : state.detectedCode;
            return Text(
              code.isNotEmpty ? code : '0000 0000 0000',
              style: context.textStyles.displayMedium,
            );
          },
        ),
      ),
    );
  }
}
