part of 'rolebloc_bloc.dart';

@immutable
abstract class RoleblocState extends Equatable {}

class RoleblocInitial extends RoleblocState {
  @override
  List<Object> get props => [];
}

final class LoadingRoleLovState extends RoleblocState {
  @override
  List<Object> get props => [];
}

final class LoadedRoleLovState extends RoleblocState {
  final List<RoleResponse> role;

  LoadedRoleLovState(this.role);

  @override
  List<Object?> get props => [role];
}

final class ErrorRoleLovState extends RoleblocState {
  final String error;

  ErrorRoleLovState({required this.error});

  @override
  List<Object?> get props => [error];
}
