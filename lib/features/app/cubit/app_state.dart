// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({this.jsonData = const {}, this.message = ''});
  final Map<String, dynamic> jsonData;
  final String message;

  AppState copyWith({Map<String, dynamic>? jsonData, String? message}) {
    return AppState(
      message: message ?? this.message,
      jsonData: jsonData ?? this.jsonData,
    );
  }

  @override
  List<Object?> get props => [jsonData, message];
}
