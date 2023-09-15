import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/domain/repositories/ForgetPasswordRepository.dart';

part 'create_new_password_event.dart';
part 'create_new_password_state.dart';

class CreateNewPasswordBloc
    extends Bloc<CreateNewPasswordEvent, CreateNewPasswordState> {
  final CreateNewPasswordRepository createNewPasswordRepo;

  CreateNewPasswordBloc({required this.createNewPasswordRepo})
      : super(CreateNewPasswordInitial()) {
    on<CreateNewPasswordButtonPressed>((event, emit) async {
      print("CreateNew Password Button Pressed event received");

      emit(CreateNewPasswordLoadingState());
      print("Emitted CreateNew Password Loading State");

      try {
        final response = await createNewPasswordRepo.userCreateNewPassword(
          event.email,
          event.otp,
        );
        print("Response: $response");
        if (response.isLeft()) {
          final failure = response.fold((failure) => failure, (_) => null);
          print("CreateNewPassword failed: $failure");
          emit(CreateNewPasswordFailureState(error: failure.toString()));
        } else {
          print("CreateNewPassword successful");

          emit(const CreateNewPasswordSuccessState(
              message: "User Created Successfully"));
          print("CreateNewPassword successful 2");
        }
      } catch (e) {
        print("CreateNewPassword failed: $e");
        emit(
          CreateNewPasswordFailureState(
            error: e.toString(),
          ),
        );
      }
    });
  }

  @override
  void onTransition(
      Transition<CreateNewPasswordEvent, CreateNewPasswordState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onChange(Change<CreateNewPasswordState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
  }

  @override
  void onEvent(CreateNewPasswordEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
