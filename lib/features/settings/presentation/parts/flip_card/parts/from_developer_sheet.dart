import 'package:card_holder/common/application/app_settings.dart';
import 'package:card_holder/common/extensions/app_extensions.dart';
import 'package:card_holder/common/presentation/widgets/skeleton_wrapper/skeleton_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FromDeveloperSheet extends StatefulWidget {
  const FromDeveloperSheet({super.key});

  static Widget show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        useRootNavigator: true,
        builder: (_) => FromDeveloperSheet(),
      );
    });

    return Text("from developer");
  }

  @override
  State<FromDeveloperSheet> createState() => _FromDeveloperSheetState();
}

class _FromDeveloperSheetState extends State<FromDeveloperSheet> {
  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mainBlack,
              borderRadius: borderRadius,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: "Привет!\n\n"),

                        const TextSpan(
                          text:
                              "Меня зовут Артур, и я рад, что вы пользуетесь приложением CardHolder.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "Это приложение всегда будет оставаться бесплатным и с открытым исходным кодом.\n\n",
                        ),

                        const TextSpan(
                          text: "Посмотреть исходный код можно здесь:\n",
                        ),

                        TextSpan(
                          text:
                              "https://github.com/GingerMustache/card_holder\n\n",
                          style: TextStyle(color: AppColors.blue700),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => _openLink(
                                      "https://github.com/GingerMustache/card_holder",
                                    ),
                        ),

                        const TextSpan(
                          text:
                              "Буду рад, если вы оставите комментарий на платформе, где его скачали. Также я всегда открыт для предложений по улучшению или ухудшению приложения.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "Я старался сделать приложение интуитивно понятным, но иногда могут возникнуть вопросы.\n",
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: AppColors.mainWhite),
                  20.h,

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Инструкция\n\n"),

                        TextSpan(text: "Добавление карты\n\n"),

                        const TextSpan(
                          text:
                              "На главной странице вы увидите кнопку «Плюс» — с её помощью можно добавить карту.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "После нажатия откроется меню с вариантами:\n\n",
                        ),

                        const TextSpan(text: "• создать карту с нуля;\n"),
                        const TextSpan(
                          text: "• использовать готовый шаблон;\n",
                        ),
                        const TextSpan(text: "• добавить карту из файла.\n\n"),

                        const TextSpan(
                          text:
                              "Создание с нуля или использование шаблона — простой процесс, и у вас не возникнет трудностей добавить карту этим способом.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "Добавить карту из файла можно просто открыв файл, которым с вами поделились, через данное приложение\n\n",
                        ),

                        TextSpan(text: "Обмен картами\n\n"),

                        const TextSpan(
                          text:
                              "Если у вас есть друзья (они же есть, правда?), вы можете обмениваться картами с ними.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "На экране добавленной карты есть кнопка «Поделиться». Нажмите её, выберите отправку файла и отправьте его куда угодно — в мессенджер, почту или другое приложение, которое всё ещё доступно.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "Ваш товарищь сможет скачать его и добавить карту через функцию добавления карты из файла, о которой говорилось выше.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "Также карточкой можно поделиться в виде фото. Да, тут можно заметить, что... А кто мне мешает сделать скриншот? Согласен, но кто мне мешает сделать такую функцию?\n\n",
                        ),

                        TextSpan(text: "Раздел «Настройки»\n\n"),

                        const TextSpan(
                          text:
                              "В разделе «Настройки» есть карточка «Поделиться».\n\n",
                        ),

                        const TextSpan(text: "Там можно:\n\n"),

                        const TextSpan(
                          text: "• поделиться ссылкой на приложение;\n",
                        ),
                        const TextSpan(
                          text: "• поделиться сразу всеми своими картами.\n\n",
                        ),

                        const TextSpan(
                          text:
                              "Функцию «поделиться всеми картами» также можно использовать как удобный способ перенести карты на новое устройство.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );
}
