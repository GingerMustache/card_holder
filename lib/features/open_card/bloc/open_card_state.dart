part of 'open_card_bloc.dart';

class OpenCardState extends Equatable {
  const OpenCardState({
    this.code = '',
    this.name = '',
    this.color = 0xffffffff,
    this.isLoading = false,
    this.error,
    this.isMarkTapped = false,
  });

  final String code;
  final String name;
  final int color;
  final bool isMarkTapped;
  final bool isLoading;
  final Exception? error;

  OpenCardState copyWith({
    String? code,
    String? name,
    int? color,
    bool? isMarkTapped,
    bool? isLoading,
    Exception? error,
  }) {
    return OpenCardState(
      name: name ?? this.name,
      code: code ?? this.code,
      color: color ?? this.color,
      isMarkTapped: isMarkTapped ?? this.isMarkTapped,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [code, name, color, isMarkTapped];
}

final class OpenCardInitial extends OpenCardState {}
