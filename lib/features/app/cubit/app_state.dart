// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({this.uriLink, this.linkLoading = false});
  final bool linkLoading;
  final Uri? uriLink;

  AppState copyWith({bool? linkLoading, Uri? uriLink}) {
    return AppState(
      linkLoading: linkLoading ?? this.linkLoading,
      uriLink: uriLink ?? this.uriLink,
    );
  }

  @override
  List<Object?> get props => [linkLoading, uriLink];
}
