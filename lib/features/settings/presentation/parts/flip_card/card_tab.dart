part of '../../screens/settings_screen.dart';

class _CardTab extends StatelessWidget {
  const _CardTab({
    required this.lang,
    required this.isSelected,
    required this.onTap,
  });
  final String lang;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          lang,
          style:
              isSelected
                  ? context.textStyles.titleSmall
                  : context.textStyles.bodySmall,
        ),
      ),
    );
  }
}
