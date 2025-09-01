import 'package:card_holder/common/mixins/error_handler_mixin.dart';
import 'package:card_holder/common/services/local_crud/local_card_service.dart';
import 'package:dartz/dartz.dart';

abstract class CardRepository {
  Future<Either<Exception, DataBaseCard>> updateCard({
    required DataBaseCard card,
    required String text,
  });
  Future<Either<Exception, DataBaseCard>> getCard({required int id});
  Future<Either<Exception, DataBaseCard>> openCard({required int id});
  Future<Either<Exception, List<DataBaseCard>>> getCards();
  Future<Either<Exception, void>> deleteAllCards();
  Future<Either<Exception, void>> deleteCard({required int id});
  Future<Either<Exception, DataBaseCard>> createCard({
    required String code,
    required String name,
  });
}

class CardRepositoryImpl with ErrorHandlerMixin implements CardRepository {
  final CardServiceAbstract localCardService;

  CardRepositoryImpl({required this.localCardService});

  @override
  Future<Either<Exception, List<DataBaseCard>>> getCards() {
    return safeCall(() => localCardService.getCards());
  }

  @override
  Future<Either<Exception, DataBaseCard>> getCard({required int id}) {
    return safeCall(() => localCardService.getCard(id: id));
  }

  @override
  Future<Either<Exception, DataBaseCard>> createCard({
    required String code,
    required String name,
  }) {
    return safeCall(() => localCardService.createCard(code: code, name: name));
  }

  @override
  Future<Either<Exception, void>> deleteAllCards() {
    return safeCall(() => localCardService.deleteAllCards());
  }

  @override
  Future<Either<Exception, void>> deleteCard({required int id}) {
    return safeCall(() => localCardService.deleteCard(id: id));
  }

  @override
  Future<Either<Exception, DataBaseCard>> updateCard({
    required DataBaseCard card,
    required String text,
  }) {
    return safeCall(() => localCardService.updateCard(card: card, text: text));
  }

  @override
  Future<Either<Exception, DataBaseCard>> openCard({required int id}) {
    return safeCall(() => localCardService.openCard(id: id));
  }
}
