///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override String get title => 'title';
	@override late final _TranslationsScreenRu screen = _TranslationsScreenRu._(_root);
	@override late final _TranslationsTabsRu tabs = _TranslationsTabsRu._(_root);
	@override late final _TranslationsOtherRu other = _TranslationsOtherRu._(_root);
	@override late final _TranslationsSystemRu system = _TranslationsSystemRu._(_root);
}

// Path: screen
class _TranslationsScreenRu extends TranslationsScreenEn {
	_TranslationsScreenRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsScreenHomeRu home = _TranslationsScreenHomeRu._(_root);
	@override late final _TranslationsScreenSettingsRu settings = _TranslationsScreenSettingsRu._(_root);
}

// Path: tabs
class _TranslationsTabsRu extends TranslationsTabsEn {
	_TranslationsTabsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get card => 'карты';
	@override String get setting => 'настройки';
}

// Path: other
class _TranslationsOtherRu extends TranslationsOtherEn {
	_TranslationsOtherRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get search => 'поисковая строка_';
	@override String get clear => 'чист';
}

// Path: system
class _TranslationsSystemRu extends TranslationsSystemEn {
	_TranslationsSystemRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSystemThemeRu theme = _TranslationsSystemThemeRu._(_root);
	@override late final _TranslationsSystemLangRu lang = _TranslationsSystemLangRu._(_root);
}

// Path: screen.home
class _TranslationsScreenHomeRu extends TranslationsScreenHomeEn {
	_TranslationsScreenHomeRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Card Holder';
	@override String get add => 'плюс';
	@override String get empty => 'пустовато';
	@override late final _TranslationsScreenHomeAddCardRu addCard = _TranslationsScreenHomeAddCardRu._(_root);
	@override late final _TranslationsScreenHomeOpenCardRu openCard = _TranslationsScreenHomeOpenCardRu._(_root);
}

// Path: screen.settings
class _TranslationsScreenSettingsRu extends TranslationsScreenSettingsEn {
	_TranslationsScreenSettingsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get all => 'first';
}

// Path: system.theme
class _TranslationsSystemThemeRu extends TranslationsSystemThemeEn {
	_TranslationsSystemThemeRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get all => 'тема';
	@override String get light => 'свет';
	@override String get dark => 'тьма';
}

// Path: system.lang
class _TranslationsSystemLangRu extends TranslationsSystemLangEn {
	_TranslationsSystemLangRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get all => 'язык';
	@override String get ru => 'русс';
	@override String get en => 'англ';
}

// Path: screen.home.addCard
class _TranslationsScreenHomeAddCardRu extends TranslationsScreenHomeAddCardEn {
	_TranslationsScreenHomeAddCardRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get barcodeScan => 'разместите штрих-код внутри рамки для сканирования';
	@override String get detectedCode => 'отсканированный код';
	@override String get manualCode => 'введите код вручную';
	@override String get cardName => 'имя карты';
	@override String get code => 'код_';
	@override String get name => 'имя_';
	@override String get color => 'цвет_';
	@override String get add => 'добавить';
}

// Path: screen.home.openCard
class _TranslationsScreenHomeOpenCardRu extends TranslationsScreenHomeOpenCardEn {
	_TranslationsScreenHomeOpenCardRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get uses => 'раз';
	@override String get edit => 'принять';
	@override String get share => 'поделиться';
	@override late final _TranslationsScreenHomeOpenCardBrightnessRu brightness = _TranslationsScreenHomeOpenCardBrightnessRu._(_root);
}

// Path: screen.home.openCard.brightness
class _TranslationsScreenHomeOpenCardBrightnessRu extends TranslationsScreenHomeOpenCardBrightnessEn {
	_TranslationsScreenHomeOpenCardBrightnessRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get all => 'яркость';
	@override String get auto => 'авто';
	@override String get handle => 'ручной';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'title': return 'title';
			case 'screen.home.name': return 'Card Holder';
			case 'screen.home.add': return 'плюс';
			case 'screen.home.empty': return 'пустовато';
			case 'screen.home.addCard.barcodeScan': return 'разместите штрих-код внутри рамки для сканирования';
			case 'screen.home.addCard.detectedCode': return 'отсканированный код';
			case 'screen.home.addCard.manualCode': return 'введите код вручную';
			case 'screen.home.addCard.cardName': return 'имя карты';
			case 'screen.home.addCard.code': return 'код_';
			case 'screen.home.addCard.name': return 'имя_';
			case 'screen.home.addCard.color': return 'цвет_';
			case 'screen.home.addCard.add': return 'добавить';
			case 'screen.home.openCard.uses': return 'раз';
			case 'screen.home.openCard.edit': return 'принять';
			case 'screen.home.openCard.share': return 'поделиться';
			case 'screen.home.openCard.brightness.all': return 'яркость';
			case 'screen.home.openCard.brightness.auto': return 'авто';
			case 'screen.home.openCard.brightness.handle': return 'ручной';
			case 'screen.settings.all': return 'first';
			case 'tabs.card': return 'карты';
			case 'tabs.setting': return 'настройки';
			case 'other.search': return 'поисковая строка_';
			case 'other.clear': return 'чист';
			case 'system.theme.all': return 'тема';
			case 'system.theme.light': return 'свет';
			case 'system.theme.dark': return 'тьма';
			case 'system.lang.all': return 'язык';
			case 'system.lang.ru': return 'русс';
			case 'system.lang.en': return 'англ';
			default: return null;
		}
	}
}

