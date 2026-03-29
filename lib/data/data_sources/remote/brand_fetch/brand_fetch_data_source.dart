import 'package:card_holder/data/models/search_shop_name_model.dart';

abstract class BrandFetchDataSource {
  Future<SearchShopNameModel> searchShopName(Object data);
}
