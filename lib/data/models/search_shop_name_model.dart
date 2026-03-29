import 'package:card_holder/common/helpers/json_parser.dart';
import 'package:card_holder/domain/entities/search_shop_name_entity.dart';

class SearchShopNameModel extends SearchShopNameEntity {
  const SearchShopNameModel({
    required super.brandId,
    required super.claimed,
    required super.domain,
    required super.name,
    required super.icon,
    required super.score,
    required super.qualityScore,
    required super.verified,
  });

  factory SearchShopNameModel.fromJson(Map<String, dynamic> json) {
    return SearchShopNameModel(
      brandId: JsonParser.toStringValue(json['brandId']),
      claimed: JsonParser.toBool(json['claimed']),
      domain: JsonParser.toStringValue(json['domain']),
      name: JsonParser.toStringValue(json['name']),
      icon: JsonParser.toStringValue(json['icon']),
      score: JsonParser.toDouble(json['_score']),
      qualityScore: JsonParser.toDouble(json['qualityScore']),
      verified: JsonParser.toBool(json['verified']),
    );
  }
}
