part of 'add_card_bloc.dart';

final class CreateCardState extends Equatable {
  const CreateCardState({
    this.code = '',
    this.detectedCode = '',
    this.name = '',
    this.urlPath = '',
    this.logoSize = 30,
    this.color = 0xffffffff,
    this.detectedName = '',
    this.isFetching = false,
    this.isMarkTapped = false,
  });

  final String code;
  final String name;
  final String urlPath;
  final double logoSize;
  final int color;
  final bool isMarkTapped;
  final String detectedCode;
  final String detectedName;
  final bool isFetching;

  CreateCardState copyWith({
    String? code,
    String? name,
    String? urlPath,
    double? logoSize,
    int? color,
    bool? isMarkTapped,
    String? detectedCode,
    String? detectedName,
    bool? isFetching,
  }) {
    return CreateCardState(
      name: name ?? this.name,
      urlPath: urlPath ?? this.urlPath,
      logoSize: logoSize ?? this.logoSize,
      code: code ?? this.code,
      color: color ?? this.color,
      isMarkTapped: isMarkTapped ?? this.isMarkTapped,
      detectedName: detectedName ?? this.detectedName,
      detectedCode: detectedCode ?? this.detectedCode,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [
        code,
        name,
        color,
        isMarkTapped,
        detectedCode,
        detectedName,
        isFetching,
        urlPath,
        logoSize,
      ];
}
