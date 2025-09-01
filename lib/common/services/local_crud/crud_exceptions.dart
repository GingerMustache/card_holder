abstract class LocalDataBaseException implements Exception {}

class DatabaseIsAlreadyOpen implements LocalDataBaseException {}

class UnableToGetDocumentsDirectory implements LocalDataBaseException {}

class DatabaseIsNotOpen implements LocalDataBaseException {}

class CouldNotDeleteUser implements LocalDataBaseException {}

class UserAlreadyExists implements LocalDataBaseException {}

class CouldNotFindUser implements LocalDataBaseException {}

class CouldNotDeleteCard implements LocalDataBaseException {}

class CouldNotFindCard implements LocalDataBaseException {}

class CouldNotUpdateCard implements LocalDataBaseException {}
