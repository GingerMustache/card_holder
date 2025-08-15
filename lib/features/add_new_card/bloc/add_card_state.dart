part of 'add_card_bloc.dart';

final class AddCardState extends Equatable {
  const AddCardState({
    this.code = '',
    this.detectedCode = '',
    this.name = '',
    this.isFetching = false,
  });
  final String code;
  final String detectedCode;
  final String name;
  final bool isFetching;

  AddCardState copyWith({
    String? code,
    String? detectedCode,
    String? name,
    bool? isFetching,
  }) {
    return AddCardState(
      code: code ?? this.code,
      detectedCode: detectedCode ?? this.detectedCode,
      name: name ?? this.name,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [code, name];
}
