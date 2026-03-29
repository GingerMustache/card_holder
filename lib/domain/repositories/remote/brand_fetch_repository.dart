import 'package:card_holder/domain/entities/search_shop_name_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BrandFetchRepository {
  Future<Either<Exception, SearchShopNameEntity?>> searchShopName({
    required Object data,
  });
}
