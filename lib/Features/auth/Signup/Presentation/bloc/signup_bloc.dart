import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/params/UserSignupInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/repositories/SignupRepository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepo;

  SignupBloc({required this.signupRepo}) : super(SignupInitialState()) {
    on<SignupButtonPressed>((event, emit) async {
      print("SignupButtonPressed event received");

      emit(SignupLoadingState());
      print("Emitted Signup Loading State");

      try {
        final response = await signupRepo.userSignup(event.input);
        print("Response: $response");
        if (response.isLeft()) {
          final failure = response.fold((failure) => failure, (_) => null);
          print("Signup failed: $failure");
          emit(SignupFailureState(error: failure.toString()));
        } else {
          print("Signup successful");

          emit(SignupSuccessState(message: "User Created Successfully"));
          print("Signup successful 2");
        }
      } catch (e) {
        print("Signup failed: $e");
        emit(SignupFailureState(error: e.toString()));
      }
    });
  }

  @override
  void onTransition(Transition<SignupEvent, SignupState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onChange(Change<SignupState> change) {
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
  void onEvent(SignupEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
