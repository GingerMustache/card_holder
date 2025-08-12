part of '../card_service.dart';

class DataBaseCard extends Equatable {
  final int id;
  final String code;
  final int usagePoint;

  const DataBaseCard({
    required this.id,
    required this.code,
    required this.usagePoint,
  });

  DataBaseCard.fromRow(Map<String, Object?> map)
    : id = map[_idColumn] as int,
      usagePoint = map[_usagePointColumn] as int,
      code = map[_codeColumn] as String;

  @override
  String toString() => "Note, ID = $id, code = $code, usagePoint = $usagePoint";

  @override
  List<Object?> get props => [id, code, usagePoint];
}
