import 'package:card_holder/common/services/local_crud/exceptions/crud_exceptions.dart';
import 'package:card_holder/common/services/share/exceptions/shared_service_exceptions.dart';
import 'package:dartz/dartz.dart';

mixin ErrorHandlerMixin {
  Future<Either<Exception, T>> safeCall<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on LocalDataBaseException catch (e) {
      return Left(e);
    } on SharedServiceExceptions catch (e) {
      return Left(e);
    } catch (e) {
      return Left(e as Exception);
    }
  }
}
