// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../local_card_service.dart';

enum CardCodeType {
  barcode,
  qr;

  static CardCodeType fromString(String value) {
    return CardCodeType.values.firstWhere((e) => e.name == value);
  }
}

class DataBaseCard extends Equatable {
  final int id;
  final String code;
  final String name;
  final int color;
  final int usagePoint;
  final String urlPath;
  final double logoSize;
  final CardCodeType cardCodeType;

  const DataBaseCard({
    required this.id,
    required this.code,
    required this.name,
    required this.color,
    required this.urlPath,
    required this.cardCodeType,
    this.usagePoint = 0,
    this.logoSize = 30,
  });

  DataBaseCard.fromRow(Map<String, Object?> map)
    : id = map[_idColumn] as int,
      usagePoint = map[_usagePointColumn] as int,
      code = map[_codeColumn] as String,
      color = map[_color] as int,
      logoSize = (map[_logoSize] as num?)?.toDouble() ?? 30,
      urlPath = map[_urlPath] as String,
      name = map[_name] as String,
      cardCodeType = CardCodeType.fromString(
        map[_cardCodeTypeColumn] as String,
      );

  @override
  String toString() =>
      "Note, ID = $id, code = $code, name = $name usagePoint = $usagePoint, color = $color, urlPath = $urlPath, logoSize = $logoSize";

  @override
  List<Object?> get props => [
    id,
    code,
    name,
    usagePoint,
    cardCodeType,
    color,
    urlPath,
    logoSize,
  ];

  DataBaseCard copyWith({
    int? id,
    String? code,
    String? name,
    int? color,
    CardCodeType? cardCodeType,
    int? usagePoint,
    String? urlPath,
    double? logoSize,
  }) {
    return DataBaseCard(
      id: id ?? this.id,
      color: color ?? this.color,
      cardCodeType: cardCodeType ?? this.cardCodeType,
      code: code ?? this.code,
      name: name ?? this.name,
      usagePoint: usagePoint ?? this.usagePoint,
      urlPath: urlPath ?? this.urlPath,
      logoSize: logoSize ?? this.logoSize,
    );
  }
}
