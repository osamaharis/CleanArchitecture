part of 'user_bloc.dart';

sealed class UserState  extends Equatable{
  // const UserState();
}
//
// final class InitailState extends UserState {}

final class RoleLovLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

final class RoleLovLoadedState extends UserState {
  // RoleLovLoadedState({
  //   required this.message,
  //   required this.listOfRoles,
  // });
  final List<RoleLovResponse> roles;
  RoleLovLoadedState(this.roles);
  @override
  List<Object?> get props => [roles];
  // String message;
  // List<RoleLovResponse> listOfRoles;
}

final class RoleLovErrorState extends UserState {
  // RoleLovErrorState({required this.error});

  final String error;
  RoleLovErrorState(this.error);
  @override
  List<Object?> get props => [error];
  // String error;
}

final class UserLovLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLovLoadedState extends UserState {
  // UserLovLoadedState({
  //   required this.message,
  //   required this.listOfUsers,
  // });
  //
  // String message;
  // List<UserLovResponse> listOfUsers;
  final List<UserLovResponse> users;
  UserLovLoadedState(this.users);
  @override
  List<Object?> get props => [users];


}

final class UserLovErrorState extends UserState {
  final String error;
  UserLovErrorState(this.error);
  @override
  List<Object?> get props => [error];
}




// final class LoadingState extends UserState {}

// final class LoadedState extends UserState {
//   LoadedState({
//     required this.message,
//     required this.listOfRoles,
//     required this.listOfUsers,
//   });

//   String message;
//   List<UserLovResponse> listOfRoles;
//   List<UserLovResponse> listOfUsers;
// }

// final class ErrorState extends UserState {
//   ErrorState({required this.error});

//   String error;
// }