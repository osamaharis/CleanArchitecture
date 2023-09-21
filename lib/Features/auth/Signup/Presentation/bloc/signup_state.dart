part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitialState extends SignupState {
  @override
  List<Object> get props => [];
}

final class SignupLoadingState extends SignupState {
  @override
  List<Object> get props => [];
}

final class SignupSuccessState extends SignupState {
  final String message;
  SignupSuccessState({required this.message});
}

final class SignupFailureState extends SignupState {
  final String error;
  SignupFailureState({required this.error});
}
