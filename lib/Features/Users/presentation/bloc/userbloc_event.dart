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
class LoadedUserLovEvent extends UserblocEvent {
final String token;
const LoadedUserLovEvent({required this.token});
  @override
  List<Object?> get props => [];
}

// @immutable
// abstract class UserblocIDEvent extends Equatable {
//   const UserblocIDEvent();
// }
class LoadedUserbyIdEvent extends UserblocEvent
{
  final token;
  final id;
  LoadedUserbyIdEvent({required this.id,required this.token});
  @override
  List<Object?> get props => [];
}