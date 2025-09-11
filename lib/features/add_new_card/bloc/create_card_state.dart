part of 'create_card_bloc.dart';

final class CreateCardState extends Equatable {
  const CreateCardState({
    this.code = '',
    this.detectedCode = '',
    this.name = '',
    this.color = 0xffffffff,
    this.detectedName = '',
    this.isFetching = false,
    this.isMarkTapped = false,
  });
  final String code;
  final String detectedCode;
  final String name;
  final int color;
  final String detectedName;
  final bool isFetching;

  final bool isMarkTapped;

  CreateCardState copyWith({
    String? code,
    String? detectedCode,
    String? detectedName,
    String? name,
    bool? isFetching,
    int? color,
    bool? isMarkTapped,
  }) {
    return CreateCardState(
      color: color ?? this.color,
      isMarkTapped: isMarkTapped ?? this.isMarkTapped,
      detectedName: detectedName ?? this.detectedName,
      code: code ?? this.code,
      detectedCode: detectedCode ?? this.detectedCode,
      name: name ?? this.name,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [
    code,
    name,
    detectedCode,
    detectedName,
    isFetching,
    color,
    isMarkTapped,
  ];
}
