part of 'userbloc_bloc.dart';

@immutable
abstract class UserblocEvent extends Equatable {
  const UserblocEvent();
}

class LoadingUserLov extends  UserblocEvent
{
  @override
  List<Object?> get props => [];

}
class LoadUserLovEvent extends UserblocEvent {
  @override
  List<Object?> get props => [];
}