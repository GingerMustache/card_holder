import 'package:equatable/equatable.dart';

class SearchShopNameEntity extends Equatable {
  final String brandId;
  final bool claimed;
  final String domain;
  final String name;
  final String icon;
  final double score;
  final double qualityScore;
  final bool verified;

  const SearchShopNameEntity({
    required this.brandId,
    required this.claimed,
    required this.domain,
    required this.name,
    required this.icon,
    required this.score,
    required this.qualityScore,
    required this.verified,
  });

  @override
  List<Object?> get props => [
    brandId,
    claimed,
    domain,
    name,
    icon,
    score,
    qualityScore,
    verified,
  ];
}
