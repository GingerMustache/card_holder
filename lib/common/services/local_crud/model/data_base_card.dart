// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../local_card_service.dart';

class DataBaseCard extends Equatable {
  final int id;
  final String code;
  final String name;
  final int usagePoint;

  const DataBaseCard({
    required this.id,
    required this.code,
    required this.name,
    this.usagePoint = 0,
  });

  DataBaseCard.fromRow(Map<String, Object?> map)
    : id = map[_idColumn] as int,
      usagePoint = map[_usagePointColumn] as int,
      code = map[_codeColumn] as String,
      name = map[_name] as String;

  @override
  String toString() =>
      "Note, ID = $id, code = $code, name = $name usagePoint = $usagePoint";

  @override
  List<Object?> get props => [id, code, name, usagePoint];

  DataBaseCard copyWith({
    int? id,
    String? code,
    String? name,
    int? usagePoint,
  }) {
    return DataBaseCard(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      usagePoint: usagePoint ?? this.usagePoint,
    );
  }
}
