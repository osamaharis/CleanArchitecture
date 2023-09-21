part of 'userbloc_bloc.dart';

@immutable
abstract class UserblocState extends Equatable {}

class UserblocInitial extends UserblocState {

  @override
  List<Object> get props => [];
}
final class LoadingUserLovState extends UserblocState {
  @override
  List<Object> get props => [];
}
final class LoadingUserbyIdLovState extends UserblocState {
  @override
  List<Object> get props => [];
}
final class LoadedUserLovState extends UserblocState {

  final List<UserLovResponse> users;
  LoadedUserLovState(this.users);
  @override
  List<Object?> get props => [users];

}
final class LoadedUserbyIdState extends UserblocState{
  final UserLovResponse? users;
  LoadedUserbyIdState(this.users);
  @override
  List<Object?> get props => [users];
}

final class ErrorUserLovState extends UserblocState {
  final String error;
  ErrorUserLovState({required this.error});
  @override
  List<Object?> get props => [error];
}
final class ErrorUserByIdState extends UserblocState {
  final String error;
  ErrorUserByIdState({required this.error});
  @override
  List<Object?> get props => [error];
}