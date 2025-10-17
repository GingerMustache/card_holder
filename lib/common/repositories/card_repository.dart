import 'package:card_holder/common/mixins/error_handler_mixin.dart';
import 'package:card_holder/common/repositories/shared_repository.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:dartz/dartz.dart';

abstract class CardRepository {
  Future<Either<Exception, DataBaseCard>> getCard({required int id});
  Future<Either<Exception, DataBaseCard>> openCard({required int id});
  Future<Either<Exception, List<DataBaseCard>>> getCards();
  Future<Either<Exception, void>> deleteAllCards();
  Future<Either<Exception, void>> deleteCard({required int id});
  Future<Either<Exception, void>> shareCardNet({
    required List<String> paths,
    required String text,
  });
  Future<Either<Exception, DataBaseCard>> updateCard({
    required int id,
    required String code,
    required String name,
    required int color,
    required String urlPath,
    required double logoSize,
  });
  Future<Either<Exception, DataBaseCard>> createCard({
    required String code,
    required String name,
    required int color,
    required String urlPath,
    required double logoSize,
  });
}

class CardRepositoryImpl with ErrorHandlerMixin implements CardRepository {
  final CardServiceAbstract localCardService;

  final ShareRepository netShareRepository;

  CardRepositoryImpl({
    required this.localCardService,
    required this.netShareRepository,
  });

  @override
  Future<Either<Exception, List<DataBaseCard>>> getCards() =>
      safeCall(() => localCardService.getCards());

  @override
  Future<Either<Exception, DataBaseCard>> getCard({required int id}) =>
      safeCall(() => localCardService.getCard(id: id));

  @override
  Future<Either<Exception, DataBaseCard>> createCard({
    required String code,
    required String name,
    required int color,
    required String urlPath,
    required double logoSize,
  }) => safeCall(
    () => localCardService.createCard(
      code: code,
      name: name,
      color: color,
      urlPath: urlPath,
      logoSize: logoSize,
    ),
  );

  @override
  Future<Either<Exception, void>> deleteAllCards() =>
      safeCall(() => localCardService.deleteAllCards());

  @override
  Future<Either<Exception, void>> deleteCard({required int id}) =>
      safeCall(() => localCardService.deleteCard(id: id));

  @override
  Future<Either<Exception, DataBaseCard>> updateCard({
    required int id,
    required String code,
    required String name,
    required int color,
    required String? urlPath,
    required double logoSize,
  }) => safeCall(
    () => localCardService.updateCard(
      id: id,
      code: code,
      name: name,
      color: color,
      urlPath: urlPath,
      logoSize: logoSize,
    ),
  );

  @override
  Future<Either<Exception, DataBaseCard>> openCard({required int id}) async =>
      safeCall(() => localCardService.openCard(id: id));

  @override
  Future<Either<Exception, void>> shareCardNet({
    required List<String> paths,
    required String text,
  }) async => netShareRepository.shareFiles(paths: paths, text: text);
}
