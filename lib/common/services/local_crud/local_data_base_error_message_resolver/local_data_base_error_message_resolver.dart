import 'package:card_holder/common/localization/i18n/strings.g.dart';
import 'package:card_holder/common/services/local_crud/exceptions/crud_exceptions.dart';

class LocalDataBaseErrorMessageResolver {
  static final Map<Type, String Function()> _defaultMessages = {
    DatabaseIsAlreadyOpen: () => t.errors.localData.databaseIsAlreadyOpen,
    UnableToGetDocumentsDirectory:
        () => t.errors.localData.unableToGetDocumentsDirectory,
    DatabaseIsNotOpen: () => t.errors.localData.databaseIsNotOpen,
    CouldNotDeleteUser: () => t.errors.localData.couldNotDeleteUser,
    UserAlreadyExists: () => t.errors.localData.userAlreadyExists,
    CouldNotFindUser: () => t.errors.localData.couldNotFindUser,
    CouldNotDeleteCard: () => t.errors.localData.couldNotDeleteCard,
    CouldNotFindCard: () => t.errors.localData.couldNotFindCard,
    CouldNotUpdateCard: () => t.errors.localData.couldNotUpdateCard,
    CouldNotCreateCard: () => t.errors.localData.couldNotCreateCard,
    CouldNotOpenCard: () => t.errors.localData.couldNotOpenCard,
    CouldNotFetchCards: () => t.errors.localData.couldNotFetchCards,
  };

  static String resolveMessage(LocalDataBaseException exception) {
    if (exception.message.isEmpty) {
      final messageGetter = _defaultMessages[exception.runtimeType];
      return messageGetter?.call() ?? t.errors.localData.unknownDatabaseError;
    }
    return exception.message;
  }

  static LocalDataBaseException withResolvedMessage(
    LocalDataBaseException exception,
  ) {
    final resolvedMessage = resolveMessage(exception);

    // If the message is already correct, return the original exception
    if (exception.message == resolvedMessage) {
      return exception;
    }

    // Create a new instance with the resolved message based on exception type
    return switch (exception.runtimeType) {
      DatabaseIsAlreadyOpen _ => DatabaseIsAlreadyOpen(resolvedMessage),
      UnableToGetDocumentsDirectory _ => UnableToGetDocumentsDirectory(
        resolvedMessage,
      ),
      DatabaseIsNotOpen _ => DatabaseIsNotOpen(resolvedMessage),
      CouldNotDeleteUser _ => CouldNotDeleteUser(resolvedMessage),
      UserAlreadyExists _ => UserAlreadyExists(resolvedMessage),
      CouldNotFindUser _ => CouldNotFindUser(resolvedMessage),
      CouldNotDeleteCard _ => CouldNotDeleteCard(resolvedMessage),
      CouldNotFindCard _ => CouldNotFindCard(resolvedMessage),
      CouldNotUpdateCard _ => CouldNotUpdateCard(resolvedMessage),
      CouldNotCreateCard _ => CouldNotCreateCard(resolvedMessage),
      CouldNotOpenCard _ => CouldNotOpenCard(resolvedMessage),
      CouldNotFetchCards _ => CouldNotFetchCards(resolvedMessage),
      _ => SomethingWentWrongWithDataBase(resolvedMessage),
    };
  }
}
