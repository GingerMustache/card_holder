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
	late final TranslationsFromDeveloperEn fromDeveloper = TranslationsFromDeveloperEn.internal(_root);
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

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Failed'
	String get fail => 'Failed';

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

// Path: fromDeveloper
class TranslationsFromDeveloperEn {
	TranslationsFromDeveloperEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hey there!'
	String get greeting => 'Hey there!';

	/// en: 'My name is Artur, and I'm glad you're using the CardHolder app.'
	String get intro => 'My name is Artur, and I\'m glad you\'re using the CardHolder app.';

	/// en: 'This app will always remain free and open source.'
	String get freeOpenSource => 'This app will always remain free and open source.';

	/// en: 'You can view the source code here'
	String get sourceCode => 'You can view the source code here';

	/// en: 'I'd appreciate it if you leave a comment on the platform where you downloaded it. I'm also always open to suggestions for improving or worsening the app.'
	String get feedback => 'I\'d appreciate it if you leave a comment on the platform where you downloaded it. I\'m also always open to suggestions for improving or worsening the app.';

	/// en: 'I tried to make the app intuitive, but sometimes questions may arise.'
	String get questions => 'I tried to make the app intuitive, but sometimes questions may arise.';

	/// en: 'Instructions'
	String get instruction => 'Instructions';

	/// en: 'Adding a card'
	String get addCardTitle => 'Adding a card';

	/// en: 'On the main page, you'll see a "Plus" button – you can use it to add a card.'
	String get addCardDescription1 => 'On the main page, you\'ll see a "Plus" button – you can use it to add a card.';

	/// en: 'After clicking, a menu will open with options'
	String get addCardDescription2 => 'After clicking, a menu will open with options';

	/// en: 'create a card from scratch;'
	String get addCardOption1 => 'create a card from scratch;';

	/// en: 'use a ready-made template;'
	String get addCardOption2 => 'use a ready-made template;';

	/// en: 'add a card from a file.'
	String get addCardOption3 => 'add a card from a file.';

	/// en: 'Creating from scratch or using a template is a simple process, and you won't have any trouble adding a card this way.'
	String get addCardDescription3 => 'Creating from scratch or using a template is a simple process, and you won\'t have any trouble adding a card this way.';

	/// en: 'You can add a card from a file by simply opening the file shared with you through this application.'
	String get addCardDescription4 => 'You can add a card from a file by simply opening the file shared with you through this application.';

	/// en: 'Sharing cards'
	String get shareCardsTitle => 'Sharing cards';

	/// en: 'If you have friends (you do, right?), you can exchange cards with them.'
	String get shareCardsDescription1 => 'If you have friends (you do, right?), you can exchange cards with them.';

	/// en: 'On the added card screen, there's a "Share" button. Click it, choose to send the file, and send it anywhere – to a messenger, email, or another app that's still available.'
	String get shareCardsDescription2 => 'On the added card screen, there\'s a "Share" button. Click it, choose to send the file, and send it anywhere – to a messenger, email, or another app that\'s still available.';

	/// en: 'Your friend will be able to download it and add the card using the "add card from file" function mentioned above.'
	String get shareCardsDescription3 => 'Your friend will be able to download it and add the card using the "add card from file" function mentioned above.';

	/// en: 'You can also share the card as a photo. Yes, you might notice that... "Who's stopping me from taking a screenshot?" I agree, but who's stopping me from making such a function?'
	String get shareCardsDescription4 => 'You can also share the card as a photo. Yes, you might notice that... "Who\'s stopping me from taking a screenshot?" I agree, but who\'s stopping me from making such a function?';

	/// en: 'Settings section'
	String get settingsSectionTitle => 'Settings section';

	/// en: 'In the "Settings" section, there's a "Share" card.'
	String get settingsSectionDescription1 => 'In the "Settings" section, there\'s a "Share" card.';

	/// en: 'There you can'
	String get settingsSectionDescription2 => 'There you can';

	/// en: 'share a link to the app;'
	String get settingsSectionOption1 => 'share a link to the app;';

	/// en: 'share all your cards at once.'
	String get settingsSectionOption2 => 'share all your cards at once.';

	/// en: 'The "share all cards" function can also be used as a convenient way to transfer cards to a new device.'
	String get settingsSectionDescription3 => 'The "share all cards" function can also be used as a convenient way to transfer cards to a new device.';

	/// en: 'https://github.com/GingerMustache/card_holder'
	String get sourceCodeLink => 'https://github.com/GingerMustache/card_holder';

	/// en: 'From developer'
	String get title => 'From developer';
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

	/// en: 'Failed to add — looks like it’s not a card'
	String get errorByLink => 'Failed to add — looks like it’s not a card';
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
			case 'screen.home.addCard.errorByLink': return 'Failed to add — looks like it’s not a card';
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
			case 'system.success': return 'Success';
			case 'system.fail': return 'Failed';
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
			case 'fromDeveloper.greeting': return 'Hey there!';
			case 'fromDeveloper.intro': return 'My name is Artur, and I\'m glad you\'re using the CardHolder app.';
			case 'fromDeveloper.freeOpenSource': return 'This app will always remain free and open source.';
			case 'fromDeveloper.sourceCode': return 'You can view the source code here';
			case 'fromDeveloper.feedback': return 'I\'d appreciate it if you leave a comment on the platform where you downloaded it. I\'m also always open to suggestions for improving or worsening the app.';
			case 'fromDeveloper.questions': return 'I tried to make the app intuitive, but sometimes questions may arise.';
			case 'fromDeveloper.instruction': return 'Instructions';
			case 'fromDeveloper.addCardTitle': return 'Adding a card';
			case 'fromDeveloper.addCardDescription1': return 'On the main page, you\'ll see a "Plus" button – you can use it to add a card.';
			case 'fromDeveloper.addCardDescription2': return 'After clicking, a menu will open with options';
			case 'fromDeveloper.addCardOption1': return 'create a card from scratch;';
			case 'fromDeveloper.addCardOption2': return 'use a ready-made template;';
			case 'fromDeveloper.addCardOption3': return 'add a card from a file.';
			case 'fromDeveloper.addCardDescription3': return 'Creating from scratch or using a template is a simple process, and you won\'t have any trouble adding a card this way.';
			case 'fromDeveloper.addCardDescription4': return 'You can add a card from a file by simply opening the file shared with you through this application.';
			case 'fromDeveloper.shareCardsTitle': return 'Sharing cards';
			case 'fromDeveloper.shareCardsDescription1': return 'If you have friends (you do, right?), you can exchange cards with them.';
			case 'fromDeveloper.shareCardsDescription2': return 'On the added card screen, there\'s a "Share" button. Click it, choose to send the file, and send it anywhere – to a messenger, email, or another app that\'s still available.';
			case 'fromDeveloper.shareCardsDescription3': return 'Your friend will be able to download it and add the card using the "add card from file" function mentioned above.';
			case 'fromDeveloper.shareCardsDescription4': return 'You can also share the card as a photo. Yes, you might notice that... "Who\'s stopping me from taking a screenshot?" I agree, but who\'s stopping me from making such a function?';
			case 'fromDeveloper.settingsSectionTitle': return 'Settings section';
			case 'fromDeveloper.settingsSectionDescription1': return 'In the "Settings" section, there\'s a "Share" card.';
			case 'fromDeveloper.settingsSectionDescription2': return 'There you can';
			case 'fromDeveloper.settingsSectionOption1': return 'share a link to the app;';
			case 'fromDeveloper.settingsSectionOption2': return 'share all your cards at once.';
			case 'fromDeveloper.settingsSectionDescription3': return 'The "share all cards" function can also be used as a convenient way to transfer cards to a new device.';
			case 'fromDeveloper.sourceCodeLink': return 'https://github.com/GingerMustache/card_holder';
			case 'fromDeveloper.title': return 'From developer';
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

