part of 'open_card_bloc.dart';

class OpenCardState extends Equatable {
  const OpenCardState({
    this.code = '',
    this.name = '',
    this.color = 0xffffffff,
    this.isLoading = false,
    this.error,
    this.isMarkTapped = false,
    this.turnBrightnessOn = true,
    this.urlPath = '',
  });

  final String code;
  final String name;
  final int color;
  final String urlPath;
  final bool isMarkTapped;
  final bool turnBrightnessOn;
  final bool isLoading;
  final Exception? error;

  OpenCardState copyWith({
    String? code,
    String? name,
    int? color,
    String? urlPath,
    bool? isMarkTapped,
    bool? turnBrightnessOn,
    bool? isLoading,
    Exception? error,
  }) {
    return OpenCardState(
      name: name ?? this.name,
      code: code ?? this.code,
      color: color ?? this.color,
      urlPath: urlPath ?? this.urlPath,
      isMarkTapped: isMarkTapped ?? this.isMarkTapped,
      turnBrightnessOn: turnBrightnessOn ?? this.turnBrightnessOn,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
    code,
    name,
    color,
    isMarkTapped,
    turnBrightnessOn,
    urlPath,
  ];
}
