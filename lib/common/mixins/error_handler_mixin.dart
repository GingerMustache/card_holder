import 'package:card_holder/common/services/local_crud/crud_exceptions.dart';
import 'package:dartz/dartz.dart';

mixin ErrorHandlerMixin {
  Future<Either<Exception, T>> safeCall<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on LocalDataBaseException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(e as Exception);
    }
  }
}
