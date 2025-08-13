///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	String get title => 'title';
	late final TranslationsScreenEn screen = TranslationsScreenEn.internal(_root);
	late final TranslationsTabsEn tabs = TranslationsTabsEn.internal(_root);
	late final TranslationsOtherEn other = TranslationsOtherEn.internal(_root);
	late final TranslationsSystemEn system = TranslationsSystemEn.internal(_root);
}

// Path: screen
class TranslationsScreenEn {
	TranslationsScreenEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsScreenHomeEn home = TranslationsScreenHomeEn.internal(_root);
	late final TranslationsScreenSettingsEn settings = TranslationsScreenSettingsEn.internal(_root);
}

// Path: tabs
class TranslationsTabsEn {
	TranslationsTabsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get card => 'cards';
	String get setting => 'setting';
}

// Path: other
class TranslationsOtherEn {
	TranslationsOtherEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get search => 'search line_';
}

// Path: system
class TranslationsSystemEn {
	TranslationsSystemEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSystemThemeEn theme = TranslationsSystemThemeEn.internal(_root);
	late final TranslationsSystemLangEn lang = TranslationsSystemLangEn.internal(_root);
}

// Path: screen.home
class TranslationsScreenHomeEn {
	TranslationsScreenHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Card Holder';
	String get add => 'add';
	late final TranslationsScreenHomeAddCardEn addCard = TranslationsScreenHomeAddCardEn.internal(_root);
}

// Path: screen.settings
class TranslationsScreenSettingsEn {
	TranslationsScreenSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get all => 'first';
}

// Path: system.theme
class TranslationsSystemThemeEn {
	TranslationsSystemThemeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get all => 'theme';
	String get light => 'light';
	String get dark => 'dark';
}

// Path: system.lang
class TranslationsSystemLangEn {
	TranslationsSystemLangEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get all => 'language';
	String get ru => 'ru';
	String get en => 'en';
}

// Path: screen.home.addCard
class TranslationsScreenHomeAddCardEn {
	TranslationsScreenHomeAddCardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get barcodeScan => 'position barcode within frame to scan automatically';
	String get detectedCode => 'detected code';
	String get manualCode => 'enter code manually\'';
	String get code => 'code_';
	String get add => 'add';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'title': return 'title';
			case 'screen.home.name': return 'Card Holder';
			case 'screen.home.add': return 'add';
			case 'screen.home.addCard.barcodeScan': return 'position barcode within frame to scan automatically';
			case 'screen.home.addCard.detectedCode': return 'detected code';
			case 'screen.home.addCard.manualCode': return 'enter code manually\'';
			case 'screen.home.addCard.code': return 'code_';
			case 'screen.home.addCard.add': return 'add';
			case 'screen.settings.all': return 'first';
			case 'tabs.card': return 'cards';
			case 'tabs.setting': return 'setting';
			case 'other.search': return 'search line_';
			case 'system.theme.all': return 'theme';
			case 'system.theme.light': return 'light';
			case 'system.theme.dark': return 'dark';
			case 'system.lang.all': return 'language';
			case 'system.lang.ru': return 'ru';
			case 'system.lang.en': return 'en';
			default: return null;
		}
	}
}

