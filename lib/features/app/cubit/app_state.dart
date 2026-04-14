// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({this.jsonData = const {}});
  final Map<String, dynamic> jsonData;

  AppState copyWith({Map<String, dynamic>? jsonData}) {
    return AppState(jsonData: jsonData ?? this.jsonData);
  }

  @override
  List<Object?> get props => [jsonData];
}
