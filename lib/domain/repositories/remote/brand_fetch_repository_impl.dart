import 'package:card_holder/common/mixins/error_handler_mixin.dart';
import 'package:card_holder/data/data_sources/remote/brand_fetch/brand_fetch_data_source.dart';
import 'package:card_holder/domain/entities/search_shop_name_entity.dart';
import 'package:card_holder/domain/repositories/remote/brand_fetch_repository.dart';
import 'package:dartz/dartz.dart';

class BrandFetchRepositoryImpl
    with ErrorHandlerMixin
    implements BrandFetchRepository {
  final BrandFetchDataSource brandFetchRemote;

  BrandFetchRepositoryImpl({required this.brandFetchRemote});

  @override
  Future<Either<Exception, SearchShopNameEntity?>> searchShopName({
    required Object data,
  }) {
    return safeCall(() => brandFetchRemote.searchShopName(data));
  }
}
