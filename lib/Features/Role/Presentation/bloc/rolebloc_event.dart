part of 'rolebloc_bloc.dart';

@immutable
abstract class RoleblocEvent extends Equatable {
  const RoleblocEvent();
}

class LoadingRoleLov extends RoleblocEvent {
  @override
  List<Object?> get props => [];
}

class LoadedRoleLovEvent extends RoleblocEvent {
  final String token;

  const LoadedRoleLovEvent({required this.token});

  @override
  List<Object?> get props => [];
}
