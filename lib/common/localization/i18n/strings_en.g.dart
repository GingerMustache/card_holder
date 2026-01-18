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

	/// en: 'title'
	String get title => 'title';

	late final TranslationsScreenEn screen = TranslationsScreenEn.internal(_root);
	late final TranslationsTabsEn tabs = TranslationsTabsEn.internal(_root);
	late final TranslationsOtherEn other = TranslationsOtherEn.internal(_root);
	late final TranslationsSystemEn system = TranslationsSystemEn.internal(_root);
	late final TranslationsShopsEn shops = TranslationsShopsEn.internal(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn.internal(_root);
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

	/// en: 'cards'
	String get card => 'cards';

	/// en: 'setting'
	String get setting => 'setting';
}

// Path: other
class TranslationsOtherEn {
	TranslationsOtherEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'search line_'
	String get search => 'search line_';

	/// en: 'del'
	String get clear => 'del';
}

// Path: system
class TranslationsSystemEn {
	TranslationsSystemEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSystemThemeEn theme = TranslationsSystemThemeEn.internal(_root);
	late final TranslationsSystemLangEn lang = TranslationsSystemLangEn.internal(_root);
	late final TranslationsSystemBrightEn bright = TranslationsSystemBrightEn.internal(_root);
	late final TranslationsSystemShareEn share = TranslationsSystemShareEn.internal(_root);
}

// Path: shops
class TranslationsShopsEn {
	TranslationsShopsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'from scratch'
	String get fromScratch => 'from scratch';

	/// en: 'from file'
	String get fromFile => 'from file';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsErrorsLocalDataEn localData = TranslationsErrorsLocalDataEn.internal(_root);
}

// Path: screen.home
class TranslationsScreenHomeEn {
	TranslationsScreenHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Card Holder'
	String get name => 'Card Holder';

	/// en: 'add'
	String get add => 'add';

	/// en: 'so empty...'
	String get empty => 'so empty...';

	late final TranslationsScreenHomeAddCardEn addCard = TranslationsScreenHomeAddCardEn.internal(_root);
	late final TranslationsScreenHomeOpenCardEn openCard = TranslationsScreenHomeOpenCardEn.internal(_root);
}

// Path: screen.settings
class TranslationsScreenSettingsEn {
	TranslationsScreenSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'first'
	String get all => 'first';
}

// Path: system.theme
class TranslationsSystemThemeEn {
	TranslationsSystemThemeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'theme'
	String get all => 'theme';

	/// en: 'light'
	String get light => 'light';

	/// en: 'dark'
	String get dark => 'dark';
}

// Path: system.lang
class TranslationsSystemLangEn {
	TranslationsSystemLangEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'language'
	String get all => 'language';

	/// en: 'ru'
	String get ru => 'ru';

	/// en: 'en'
	String get en => 'en';
}

// Path: system.bright
class TranslationsSystemBrightEn {
	TranslationsSystemBrightEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'bright'
	String get all => 'bright';

	/// en: 'auto'
	String get auto => 'auto';

	/// en: 'handle'
	String get handle => 'handle';
}

// Path: system.share
class TranslationsSystemShareEn {
	TranslationsSystemShareEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'share'
	String get all => 'share';

	/// en: 'app link'
	String get app => 'app link';

	/// en: 'all cards'
	String get cards => 'all cards';
}

// Path: errors.localData
class TranslationsErrorsLocalDataEn {
	TranslationsErrorsLocalDataEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Database is already open'
	String get databaseIsAlreadyOpen => 'Database is already open';

	/// en: 'Unable to get documents directory'
	String get unableToGetDocumentsDirectory => 'Unable to get documents directory';

	/// en: 'Database is not open'
	String get databaseIsNotOpen => 'Database is not open';

	/// en: 'Could not delete user'
	String get couldNotDeleteUser => 'Could not delete user';

	/// en: 'User already exists'
	String get userAlreadyExists => 'User already exists';

	/// en: 'Could not find user'
	String get couldNotFindUser => 'Could not find user';

	/// en: 'Could not delete card'
	String get couldNotDeleteCard => 'Could not delete card';

	/// en: 'Could not find card'
	String get couldNotFindCard => 'Could not find card';

	/// en: 'Could not update card'
	String get couldNotUpdateCard => 'Could not update card';

	/// en: 'Could not create card'
	String get couldNotCreateCard => 'Could not create card';

	/// en: 'Could not open card'
	String get couldNotOpenCard => 'Could not open card';

	/// en: 'Could not fetch cards'
	String get couldNotFetchCards => 'Could not fetch cards';

	/// en: 'Unknown database error'
	String get unknownDatabaseError => 'Unknown database error';
}

// Path: screen.home.addCard
class TranslationsScreenHomeAddCardEn {
	TranslationsScreenHomeAddCardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'position barcode within frame to scan automatically'
	String get barcodeScan => 'position barcode within frame to scan automatically';

	/// en: 'detected code'
	String get detectedCode => 'detected code';

	/// en: 'enter code manually'
	String get manualCode => 'enter code manually';

	/// en: 'card name'
	String get cardName => 'card name';

	/// en: 'code_'
	String get code => 'code_';

	/// en: 'name_'
	String get name => 'name_';

	/// en: 'color_'
	String get color => 'color_';

	/// en: 'add'
	String get add => 'add';

	/// en: 'Field cannot be empty'
	String get fieldCannotBeEmpty => 'Field cannot be empty';

	/// en: 'Tap to continue'
	String get tapToContinue => 'Tap to continue';
}

// Path: screen.home.openCard
class TranslationsScreenHomeOpenCardEn {
	TranslationsScreenHomeOpenCardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'uses'
	String get uses => 'uses';

	/// en: 'edit'
	String get edit => 'edit';

	/// en: 'share'
	String get share => 'share';

	/// en: 'file'
	String get file => 'file';

	/// en: 'image'
	String get image => 'image';

	/// en: 'delete?'
	String get deleteQuestion => 'delete?';

	/// en: 'yes'
	String get yes => 'yes';

	/// en: 'delete'
	String get delete => 'delete';

	/// en: 'no'
	String get no => 'no';

	/// en: 'Code is not recognized as a valid loyalty card. Verify the entered or scanned code.'
	String get codeNotRecognized => 'Code is not recognized as a valid loyalty card. Verify the entered or scanned code.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'title': return 'title';
			case 'screen.home.name': return 'Card Holder';
			case 'screen.home.add': return 'add';
			case 'screen.home.empty': return 'so empty...';
			case 'screen.home.addCard.barcodeScan': return 'position barcode within frame to scan automatically';
			case 'screen.home.addCard.detectedCode': return 'detected code';
			case 'screen.home.addCard.manualCode': return 'enter code manually';
			case 'screen.home.addCard.cardName': return 'card name';
			case 'screen.home.addCard.code': return 'code_';
			case 'screen.home.addCard.name': return 'name_';
			case 'screen.home.addCard.color': return 'color_';
			case 'screen.home.addCard.add': return 'add';
			case 'screen.home.addCard.fieldCannotBeEmpty': return 'Field cannot be empty';
			case 'screen.home.addCard.tapToContinue': return 'Tap to continue';
			case 'screen.home.openCard.uses': return 'uses';
			case 'screen.home.openCard.edit': return 'edit';
			case 'screen.home.openCard.share': return 'share';
			case 'screen.home.openCard.file': return 'file';
			case 'screen.home.openCard.image': return 'image';
			case 'screen.home.openCard.deleteQuestion': return 'delete?';
			case 'screen.home.openCard.yes': return 'yes';
			case 'screen.home.openCard.delete': return 'delete';
			case 'screen.home.openCard.no': return 'no';
			case 'screen.home.openCard.codeNotRecognized': return 'Code is not recognized as a valid loyalty card. Verify the entered or scanned code.';
			case 'screen.settings.all': return 'first';
			case 'tabs.card': return 'cards';
			case 'tabs.setting': return 'setting';
			case 'other.search': return 'search line_';
			case 'other.clear': return 'del';
			case 'system.theme.all': return 'theme';
			case 'system.theme.light': return 'light';
			case 'system.theme.dark': return 'dark';
			case 'system.lang.all': return 'language';
			case 'system.lang.ru': return 'ru';
			case 'system.lang.en': return 'en';
			case 'system.bright.all': return 'bright';
			case 'system.bright.auto': return 'auto';
			case 'system.bright.handle': return 'handle';
			case 'system.share.all': return 'share';
			case 'system.share.app': return 'app link';
			case 'system.share.cards': return 'all cards';
			case 'shops.fromScratch': return 'from scratch';
			case 'shops.fromFile': return 'from file';
			case 'errors.localData.databaseIsAlreadyOpen': return 'Database is already open';
			case 'errors.localData.unableToGetDocumentsDirectory': return 'Unable to get documents directory';
			case 'errors.localData.databaseIsNotOpen': return 'Database is not open';
			case 'errors.localData.couldNotDeleteUser': return 'Could not delete user';
			case 'errors.localData.userAlreadyExists': return 'User already exists';
			case 'errors.localData.couldNotFindUser': return 'Could not find user';
			case 'errors.localData.couldNotDeleteCard': return 'Could not delete card';
			case 'errors.localData.couldNotFindCard': return 'Could not find card';
			case 'errors.localData.couldNotUpdateCard': return 'Could not update card';
			case 'errors.localData.couldNotCreateCard': return 'Could not create card';
			case 'errors.localData.couldNotOpenCard': return 'Could not open card';
			case 'errors.localData.couldNotFetchCards': return 'Could not fetch cards';
			case 'errors.localData.unknownDatabaseError': return 'Unknown database error';
			default: return null;
		}
	}
}

