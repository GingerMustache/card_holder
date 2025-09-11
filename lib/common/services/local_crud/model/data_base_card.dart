// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../local_card_service.dart';

class DataBaseCard extends Equatable {
  final int id;
  final String code;
  final String name;
  final int color;
  final int usagePoint;

  const DataBaseCard({
    required this.id,
    required this.code,
    required this.name,
    required this.color,
    this.usagePoint = 0,
  });

  DataBaseCard.fromRow(Map<String, Object?> map)
    : id = map[_idColumn] as int,
      usagePoint = map[_usagePointColumn] as int,
      code = map[_codeColumn] as String,
      color = map[_color] as int,
      name = map[_name] as String;

  @override
  String toString() =>
      "Note, ID = $id, code = $code, name = $name usagePoint = $usagePoint, color = $color";

  @override
  List<Object?> get props => [id, code, name, usagePoint, color];

  DataBaseCard copyWith({
    int? id,
    String? code,
    String? name,
    int? color,
    int? usagePoint,
  }) {
    return DataBaseCard(
      id: id ?? this.id,
      color: color ?? this.color,
      code: code ?? this.code,
      name: name ?? this.name,
      usagePoint: usagePoint ?? this.usagePoint,
    );
  }
}
