part of '../../../../../home/presentation/screens/home_screen.dart';

class _ChooseLang extends StatefulWidget {
  @override
  State<_ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<_ChooseLang> {
  String _selectedLanguage = 'en';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _selectedLanguage = LocaleClass.lngCode(context));
    });
  }

  void _onLanguageSelected(String lang) async {
    setState(() => _selectedLanguage = lang);
    final isRu = lang == 'ru';

    await SecureStorage().write(key: SecureKeys.lang.name, value: lang);
    LocaleSettings.setLocale(isRu ? AppLocale.ru : AppLocale.en);
    await FlutterI18n.refresh(
      context,
      isRu ? LocaleClass.lngRu : LocaleClass.lngEn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _LangTab(
          lang: 'ru',
          isSelected: _selectedLanguage == 'ru',
          onTap: () => _onLanguageSelected('ru'),
        ),
        _LangTab(
          lang: 'en',
          isSelected: _selectedLanguage == 'en',
          onTap: () => _onLanguageSelected('en'),
        ),
      ],
    );
  }
}

class _LangTab extends StatelessWidget {
  const _LangTab({
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
