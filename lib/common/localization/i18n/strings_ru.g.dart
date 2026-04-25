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
	@override late final _TranslationsShopsRu shops = _TranslationsShopsRu._(_root);
	@override late final _TranslationsFromDeveloperRu fromDeveloper = _TranslationsFromDeveloperRu._(_root);
	@override late final _TranslationsErrorsRu errors = _TranslationsErrorsRu._(_root);
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
	@override String get success => 'Успешно';
	@override String get fail => 'Не успешно';
	@override late final _TranslationsSystemThemeRu theme = _TranslationsSystemThemeRu._(_root);
	@override late final _TranslationsSystemLangRu lang = _TranslationsSystemLangRu._(_root);
	@override late final _TranslationsSystemBrightRu bright = _TranslationsSystemBrightRu._(_root);
	@override late final _TranslationsSystemShareRu share = _TranslationsSystemShareRu._(_root);
}

// Path: shops
class _TranslationsShopsRu extends TranslationsShopsEn {
	_TranslationsShopsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get fromScratch => 'с нуля';
	@override String get fromFile => 'из файла';
}

// Path: fromDeveloper
class _TranslationsFromDeveloperRu extends TranslationsFromDeveloperEn {
	_TranslationsFromDeveloperRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Привет!';
	@override String get intro => 'Меня зовут Артур, и я рад, что вы пользуетесь приложением CardHolder.';
	@override String get freeOpenSource => 'Это приложение всегда будет оставаться бесплатным и с открытым исходным кодом.';
	@override String get sourceCode => 'Посмотреть исходный код можно здесь';
	@override String get feedback => 'Буду рад, если вы оставите комментарий на платформе, где его скачали. Также я всегда открыт для предложений по улучшению или ухудшению приложения.';
	@override String get questions => 'Я старался сделать приложение интуитивно понятным, но иногда могут возникнуть вопросы.';
	@override String get instruction => 'Инструкция';
	@override String get addCardTitle => 'Добавление карты';
	@override String get addCardDescription1 => 'На главной странице вы увидите кнопку «Плюс» — с её помощью можно добавить карту.';
	@override String get addCardDescription2 => 'После нажатия откроется меню с вариантами';
	@override String get addCardOption1 => 'создать карту с нуля;';
	@override String get addCardOption2 => 'использовать готовый шаблон;';
	@override String get addCardOption3 => 'добавить карту из файла.';
	@override String get addCardDescription3 => 'Создание с нуля или использование шаблона — простой процесс, и у вас не возникнет трудностей добавить карту этим способом.';
	@override String get addCardDescription4 => 'Добавить карту из файла можно просто открыв файл, которым с вами поделились, через данное приложение';
	@override String get shareCardsTitle => 'Обмен картами';
	@override String get shareCardsDescription1 => 'Если у вас есть друзья (они же есть, правда?), вы можете обмениваться картами с ними.';
	@override String get shareCardsDescription2 => 'На экране добавленной карты есть кнопка «Поделиться». Нажмите её, выберите отправку файла и отправьте его куда угодно — в мессенджер, почту или другое приложение, которое всё ещё доступно.';
	@override String get shareCardsDescription3 => 'Ваш товарищь сможет скачать его и добавить карту через функцию добавления карты из файла, о которой говорилось выше.';
	@override String get shareCardsDescription4 => 'Также карточкой можно поделиться в виде фото. Да, тут можно заметить, что... А кто мне мешает сделать скриншот? Согласен, но кто мне мешает сделать такую функцию?';
	@override String get settingsSectionTitle => 'Раздел «Настройки»';
	@override String get settingsSectionDescription1 => 'В разделе «Настройки» есть карточка «Поделиться».';
	@override String get settingsSectionDescription2 => 'Там можно';
	@override String get settingsSectionOption1 => 'поделиться ссылкой на приложение;';
	@override String get settingsSectionOption2 => 'поделиться сразу всеми своими картами.';
	@override String get settingsSectionDescription3 => 'Функцию «поделиться всеми картами» также можно использовать как удобный способ перенести карты на новое устройство.';
	@override String get sourceCodeLink => 'https://github.com/GingerMustache/card_holder';
	@override String get title => 'от разработчика';
}

// Path: errors
class _TranslationsErrorsRu extends TranslationsErrorsEn {
	_TranslationsErrorsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsErrorsLocalDataRu localData = _TranslationsErrorsLocalDataRu._(_root);
}

// Path: screen.home
class _TranslationsScreenHomeRu extends TranslationsScreenHomeEn {
	_TranslationsScreenHomeRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Card Holder';
	@override String get add => 'плюс';
	@override String get empty => 'пустовато...';
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

// Path: system.bright
class _TranslationsSystemBrightRu extends TranslationsSystemBrightEn {
	_TranslationsSystemBrightRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get all => 'яркость';
	@override String get auto => 'авто';
	@override String get handle => 'ручной';
}

// Path: system.share
class _TranslationsSystemShareRu extends TranslationsSystemShareEn {
	_TranslationsSystemShareRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get all => 'поделиться';
	@override String get app => 'приложением';
	@override String get cards => 'картами';
}

// Path: errors.localData
class _TranslationsErrorsLocalDataRu extends TranslationsErrorsLocalDataEn {
	_TranslationsErrorsLocalDataRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get databaseIsAlreadyOpen => 'База данных уже открыта';
	@override String get unableToGetDocumentsDirectory => 'Не удается получить папку документов';
	@override String get databaseIsNotOpen => 'База данных не открыта';
	@override String get couldNotDeleteUser => 'Не удалось удалить пользователя';
	@override String get userAlreadyExists => 'Пользователь уже существует';
	@override String get couldNotFindUser => 'Не удалось найти пользователя';
	@override String get couldNotDeleteCard => 'Не удалось удалить карту';
	@override String get couldNotFindCard => 'Не удалось найти карту';
	@override String get couldNotUpdateCard => 'Не удалось обновить карту';
	@override String get couldNotCreateCard => 'Не удалось создать карту';
	@override String get couldNotOpenCard => 'Не удалось открыть карту';
	@override String get couldNotFetchCards => 'Не удалось загрузить карты';
	@override String get unknownDatabaseError => 'Неизвестная ошибка базы данных';
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
	@override String get fieldCannotBeEmpty => 'Поле не может быть пустым';
	@override String get tapToContinue => 'Нажмите чтобы продолжить';
	@override String get errorByLink => 'Добавить не удалось, походу не карта';
}

// Path: screen.home.openCard
class _TranslationsScreenHomeOpenCardRu extends TranslationsScreenHomeOpenCardEn {
	_TranslationsScreenHomeOpenCardRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get uses => 'раз';
	@override String get edit => 'принять';
	@override String get share => 'поделиться';
	@override String get file => 'файл';
	@override String get image => 'фото';
	@override String get deleteQuestion => 'удалить?';
	@override String get yes => 'да';
	@override String get delete => 'удалить';
	@override String get no => 'нет';
	@override String get codeNotRecognized => 'Код не по формату карт лояльности, проверь введенный или отсканированный код еще раз';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'title': return 'title';
			case 'screen.home.name': return 'Card Holder';
			case 'screen.home.add': return 'плюс';
			case 'screen.home.empty': return 'пустовато...';
			case 'screen.home.addCard.barcodeScan': return 'разместите штрих-код внутри рамки для сканирования';
			case 'screen.home.addCard.detectedCode': return 'отсканированный код';
			case 'screen.home.addCard.manualCode': return 'введите код вручную';
			case 'screen.home.addCard.cardName': return 'имя карты';
			case 'screen.home.addCard.code': return 'код_';
			case 'screen.home.addCard.name': return 'имя_';
			case 'screen.home.addCard.color': return 'цвет_';
			case 'screen.home.addCard.add': return 'добавить';
			case 'screen.home.addCard.fieldCannotBeEmpty': return 'Поле не может быть пустым';
			case 'screen.home.addCard.tapToContinue': return 'Нажмите чтобы продолжить';
			case 'screen.home.addCard.errorByLink': return 'Добавить не удалось, походу не карта';
			case 'screen.home.openCard.uses': return 'раз';
			case 'screen.home.openCard.edit': return 'принять';
			case 'screen.home.openCard.share': return 'поделиться';
			case 'screen.home.openCard.file': return 'файл';
			case 'screen.home.openCard.image': return 'фото';
			case 'screen.home.openCard.deleteQuestion': return 'удалить?';
			case 'screen.home.openCard.yes': return 'да';
			case 'screen.home.openCard.delete': return 'удалить';
			case 'screen.home.openCard.no': return 'нет';
			case 'screen.home.openCard.codeNotRecognized': return 'Код не по формату карт лояльности, проверь введенный или отсканированный код еще раз';
			case 'screen.settings.all': return 'first';
			case 'tabs.card': return 'карты';
			case 'tabs.setting': return 'настройки';
			case 'other.search': return 'поисковая строка_';
			case 'other.clear': return 'чист';
			case 'system.success': return 'Успешно';
			case 'system.fail': return 'Не успешно';
			case 'system.theme.all': return 'тема';
			case 'system.theme.light': return 'свет';
			case 'system.theme.dark': return 'тьма';
			case 'system.lang.all': return 'язык';
			case 'system.lang.ru': return 'русс';
			case 'system.lang.en': return 'англ';
			case 'system.bright.all': return 'яркость';
			case 'system.bright.auto': return 'авто';
			case 'system.bright.handle': return 'ручной';
			case 'system.share.all': return 'поделиться';
			case 'system.share.app': return 'приложением';
			case 'system.share.cards': return 'картами';
			case 'shops.fromScratch': return 'с нуля';
			case 'shops.fromFile': return 'из файла';
			case 'fromDeveloper.greeting': return 'Привет!';
			case 'fromDeveloper.intro': return 'Меня зовут Артур, и я рад, что вы пользуетесь приложением CardHolder.';
			case 'fromDeveloper.freeOpenSource': return 'Это приложение всегда будет оставаться бесплатным и с открытым исходным кодом.';
			case 'fromDeveloper.sourceCode': return 'Посмотреть исходный код можно здесь';
			case 'fromDeveloper.feedback': return 'Буду рад, если вы оставите комментарий на платформе, где его скачали. Также я всегда открыт для предложений по улучшению или ухудшению приложения.';
			case 'fromDeveloper.questions': return 'Я старался сделать приложение интуитивно понятным, но иногда могут возникнуть вопросы.';
			case 'fromDeveloper.instruction': return 'Инструкция';
			case 'fromDeveloper.addCardTitle': return 'Добавление карты';
			case 'fromDeveloper.addCardDescription1': return 'На главной странице вы увидите кнопку «Плюс» — с её помощью можно добавить карту.';
			case 'fromDeveloper.addCardDescription2': return 'После нажатия откроется меню с вариантами';
			case 'fromDeveloper.addCardOption1': return 'создать карту с нуля;';
			case 'fromDeveloper.addCardOption2': return 'использовать готовый шаблон;';
			case 'fromDeveloper.addCardOption3': return 'добавить карту из файла.';
			case 'fromDeveloper.addCardDescription3': return 'Создание с нуля или использование шаблона — простой процесс, и у вас не возникнет трудностей добавить карту этим способом.';
			case 'fromDeveloper.addCardDescription4': return 'Добавить карту из файла можно просто открыв файл, которым с вами поделились, через данное приложение';
			case 'fromDeveloper.shareCardsTitle': return 'Обмен картами';
			case 'fromDeveloper.shareCardsDescription1': return 'Если у вас есть друзья (они же есть, правда?), вы можете обмениваться картами с ними.';
			case 'fromDeveloper.shareCardsDescription2': return 'На экране добавленной карты есть кнопка «Поделиться». Нажмите её, выберите отправку файла и отправьте его куда угодно — в мессенджер, почту или другое приложение, которое всё ещё доступно.';
			case 'fromDeveloper.shareCardsDescription3': return 'Ваш товарищь сможет скачать его и добавить карту через функцию добавления карты из файла, о которой говорилось выше.';
			case 'fromDeveloper.shareCardsDescription4': return 'Также карточкой можно поделиться в виде фото. Да, тут можно заметить, что... А кто мне мешает сделать скриншот? Согласен, но кто мне мешает сделать такую функцию?';
			case 'fromDeveloper.settingsSectionTitle': return 'Раздел «Настройки»';
			case 'fromDeveloper.settingsSectionDescription1': return 'В разделе «Настройки» есть карточка «Поделиться».';
			case 'fromDeveloper.settingsSectionDescription2': return 'Там можно';
			case 'fromDeveloper.settingsSectionOption1': return 'поделиться ссылкой на приложение;';
			case 'fromDeveloper.settingsSectionOption2': return 'поделиться сразу всеми своими картами.';
			case 'fromDeveloper.settingsSectionDescription3': return 'Функцию «поделиться всеми картами» также можно использовать как удобный способ перенести карты на новое устройство.';
			case 'fromDeveloper.sourceCodeLink': return 'https://github.com/GingerMustache/card_holder';
			case 'fromDeveloper.title': return 'от разработчика';
			case 'errors.localData.databaseIsAlreadyOpen': return 'База данных уже открыта';
			case 'errors.localData.unableToGetDocumentsDirectory': return 'Не удается получить папку документов';
			case 'errors.localData.databaseIsNotOpen': return 'База данных не открыта';
			case 'errors.localData.couldNotDeleteUser': return 'Не удалось удалить пользователя';
			case 'errors.localData.userAlreadyExists': return 'Пользователь уже существует';
			case 'errors.localData.couldNotFindUser': return 'Не удалось найти пользователя';
			case 'errors.localData.couldNotDeleteCard': return 'Не удалось удалить карту';
			case 'errors.localData.couldNotFindCard': return 'Не удалось найти карту';
			case 'errors.localData.couldNotUpdateCard': return 'Не удалось обновить карту';
			case 'errors.localData.couldNotCreateCard': return 'Не удалось создать карту';
			case 'errors.localData.couldNotOpenCard': return 'Не удалось открыть карту';
			case 'errors.localData.couldNotFetchCards': return 'Не удалось загрузить карты';
			case 'errors.localData.unknownDatabaseError': return 'Неизвестная ошибка базы данных';
			default: return null;
		}
	}
}

