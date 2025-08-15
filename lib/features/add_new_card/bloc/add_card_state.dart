part of 'add_card_bloc.dart';

final class AddCardState extends Equatable {
  const AddCardState({this.code = '', this.name = '', this.isFetching = false});
  final String code;
  final String name;
  final bool isFetching;

  AddCardState copyWith({String? code, String? name, bool? isFetching}) {
    return AddCardState(
      code: code ?? this.code,
      name: name ?? this.name,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [code, name];
}
