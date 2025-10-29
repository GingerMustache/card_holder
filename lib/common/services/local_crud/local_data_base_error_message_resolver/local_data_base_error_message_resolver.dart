import 'package:card_holder/common/services/local_crud/exceptions/crud_exceptions.dart';

/// Class responsible for resolving default error messages for LocalDataBaseException instances
class LocalDataBaseErrorMessageResolver {
  /// Map of exception types to their default error messages
  static const Map<Type, String> _defaultMessages = {
    DatabaseIsAlreadyOpen: 'Database is already open',
    UnableToGetDocumentsDirectory: 'Unable to get documents directory',
    DatabaseIsNotOpen: 'Database is not open',
    CouldNotDeleteUser: 'Could not delete user',
    UserAlreadyExists: 'User already exists',
    CouldNotFindUser: 'Could not find user',
    CouldNotDeleteCard: 'Could not delete card',
    CouldNotFindCard: 'Could not find card',
    CouldNotUpdateCard: 'Could not update card',
    CouldNotCreateCard: 'Could not create card',
    CouldNotOpenCard: 'Could not open card',
    CouldNotFetchCards: 'Could not fetch cards',
  };

  /// Resolves the appropriate error message for a LocalDataBaseException
  /// If the exception has an empty message, returns the default message for its type
  /// Otherwise, returns the original message
  static String resolveMessage(LocalDataBaseException exception) {
    if (exception.message.isEmpty) {
      return _defaultMessages[exception.runtimeType] ??
          'Unknown database error';
    }
    return exception.message;
  }

  /// Creates a new exception instance with the resolved message
  /// This ensures that exceptions always have meaningful messages
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
