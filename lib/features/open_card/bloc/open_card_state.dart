part of 'open_card_bloc.dart';

class OpenCardState extends Equatable {
  const OpenCardState({
    this.code = '',
    this.name = '',
    this.isLoading = false,
    this.error,
  });

  final String code;
  final String name;
  final bool isLoading;
  final Exception? error;

  OpenCardState copyWith({
    String? code,
    String? name,
    bool? isLoading,
    Exception? error,
  }) {
    return OpenCardState(
      code: code ?? this.code,
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [];
}

final class OpenCardInitial extends OpenCardState {}
