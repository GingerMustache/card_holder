part of '../card_add_sheet.dart';

class _EnteredCodeWidget extends StatelessWidget {
  const _EnteredCodeWidget();

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      child: Center(
        child: BlocBuilder<CreateCardBloc, CreateCardState>(
          buildWhen:
              (previous, current) =>
                  previous.code != current.code ||
                  previous.detectedCode != current.detectedCode,
          builder: (context, state) {
            final code =
                state.code.isNotEmpty ? state.code : state.detectedCode;
            final isQr = code.containsAlphabetic;
            final showDetectedString =
                isQr
                    ? "QR"
                    : code.isNotEmpty
                    ? code
                    : '0000 0000 0000';

            return Text(
              showDetectedString.toString(),
              style: context.textStyles.displayMedium,
            );
          },
        ),
      ),
    );
  }
}
