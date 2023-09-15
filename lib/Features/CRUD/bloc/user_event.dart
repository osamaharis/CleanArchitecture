part of 'user_bloc.dart';
@immutable
sealed class LovEvent extends Equatable {
  const LovEvent();

  // @override
  // List<Object> get props => [];
}

class LoadRoleLovEvent extends LovEvent {
  @override
  List<Object?> get props => [];
}

class LoadUserLovEvent extends LovEvent {
  @override
  List<Object?> get props => [];
}

