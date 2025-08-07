part of '../../screens/settings_screen.dart';

class _CardTab extends StatelessWidget {
  const _CardTab({
    required this.tabName,
    required this.isSelected,
    required this.onTap,
  });
  final String tabName;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          tabName,
          style:
              isSelected
                  ? context.textStyles.titleSmall
                  : context.textStyles.bodySmall,
        ),
      ),
    );
  }
}
