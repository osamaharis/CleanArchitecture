part of 'create_new_password_bloc.dart';

sealed class CreateNewPasswordEvent extends Equatable {
  const CreateNewPasswordEvent();

  @override
  List<Object> get props => [];
}

class CreateNewPasswordButtonPressed extends CreateNewPasswordEvent {
  final String email;
  final String otp;
  const CreateNewPasswordButtonPressed({
    required this.email,
    required this.otp,
  });
}
