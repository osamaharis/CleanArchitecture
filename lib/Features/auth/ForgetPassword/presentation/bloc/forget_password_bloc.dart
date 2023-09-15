import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/Domain/repositories/ForgetPasswordRepository.dart';
import 'package:project_cleanarchiteture/Utils/TextResources.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordRepository forgetPasswordRepo;

  ForgetPasswordBloc({required this.forgetPasswordRepo})
      : super(ForgetPasswordInitialState()) {
    on<ForgetPasswordButtonPressed>((event, emit) async {
      print("Forget Password Button Pressed event received");

      emit(ForgetPasswordLoadingState());
      print("Emitted Forget Password Loading State");

      try {
        final response =
        await forgetPasswordRepo.forget(event.email);
            // await forgetPasswordRepo.userForgetPassword(event.email);
        print("Response: $response");
        // if (response.isLeft()) {
        //   final failure = response.fold((failure) => failure, (_) => null);
        //   print("ForgetPassword failed: $failure");
        //   emit(ForgetPasswordFailureState(error: failure.toString()));
        // }

          print("ForgetPassword successful");
          emit(const ForgetPasswordSuccessState(
              message: "User Created Successfully"));
          print("ForgetPassword successful 2");

      } catch (e) {
        print("ForgetPassword failed: $e");
        emit(
          ForgetPasswordFailureState(
            error: e.toString(),
          ),
        );
      }
    });
  }

  @override
  void onTransition(
      Transition<ForgetPasswordEvent, ForgetPasswordState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onChange(Change<ForgetPasswordState> change) {
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
  void onEvent(ForgetPasswordEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
