abstract class LocalDataBaseException implements Exception {
  final String message;
  final Object? originalError;

  const LocalDataBaseException(this.message, {this.originalError});

  @override
  String toString() => 'LocalDataBaseException: $message';
}

class SomethingWentWrongWithDataBase extends LocalDataBaseException {
  const SomethingWentWrongWithDataBase([String? errorMessage])
    : super(errorMessage ?? '');
}

class DatabaseIsAlreadyOpen extends LocalDataBaseException {
  const DatabaseIsAlreadyOpen([String? errorMessage])
    : super(errorMessage ?? '');
}

class UnableToGetDocumentsDirectory extends LocalDataBaseException {
  const UnableToGetDocumentsDirectory([String? errorMessage])
    : super(errorMessage ?? '');
}

class DatabaseIsNotOpen extends LocalDataBaseException {
  const DatabaseIsNotOpen([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotDeleteUser extends LocalDataBaseException {
  const CouldNotDeleteUser([String? errorMessage]) : super(errorMessage ?? '');
}

class UserAlreadyExists extends LocalDataBaseException {
  const UserAlreadyExists([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotFindUser extends LocalDataBaseException {
  const CouldNotFindUser([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotDeleteCard extends LocalDataBaseException {
  const CouldNotDeleteCard([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotFindCard extends LocalDataBaseException {
  const CouldNotFindCard([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotFetchCards extends LocalDataBaseException {
  const CouldNotFetchCards([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotUpdateCard extends LocalDataBaseException {
  const CouldNotUpdateCard([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotCreateCard extends LocalDataBaseException {
  const CouldNotCreateCard([String? errorMessage]) : super(errorMessage ?? '');
}

class CouldNotOpenCard extends LocalDataBaseException {
  const CouldNotOpenCard([String? errorMessage]) : super(errorMessage ?? '');
}
