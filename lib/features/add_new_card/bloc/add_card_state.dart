part of 'add_card_bloc.dart';

final class AddCardState extends Equatable {
  const AddCardState({
    this.code = '',
    this.detectedCode = '',
    this.name = '',
    this.detectedName = '',
    this.isFetching = false,
  });
  final String code;
  final String detectedCode;
  final String name;
  final String detectedName;
  final bool isFetching;

  AddCardState copyWith({
    String? code,
    String? detectedCode,
    String? detectedName,
    String? name,
    bool? isFetching,
  }) {
    return AddCardState(
      detectedName: detectedName ?? this.detectedName,
      code: code ?? this.code,
      detectedCode: detectedCode ?? this.detectedCode,
      name: name ?? this.name,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [code, name, detectedCode, detectedName];
}
