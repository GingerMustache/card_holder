import 'package:card_holder/common/mixins/request/request_mixin.dart';
import 'package:card_holder/data/data_sources/remote/brand_fetch/brand_fetch_data_source.dart';
import 'package:card_holder/data/models/search_shop_name_model.dart';
import 'package:dio/dio.dart';

class BrandFetchDataSourceImpl
    with RequestMixin
    implements BrandFetchDataSource {
  @override
  final Dio dioClient;

  final String host;

  BrandFetchDataSourceImpl(this.dioClient, this.host);

  String hostUrl(String path) => '$host$path';

  @override
  Future<SearchShopNameModel> searchShopName(Object data) {
    return postSingle(
      path: hostUrl(''),
      data: data,
      fromJson: SearchShopNameModel.fromJson,
    );
  }
}
