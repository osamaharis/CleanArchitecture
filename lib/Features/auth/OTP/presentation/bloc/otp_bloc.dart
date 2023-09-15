import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Features/auth/OTP/domain/repositories/OtpRepository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository otpRepo;

  OtpBloc({required this.otpRepo}) : super(OtpInitialState()) {
    on<OtpButtonPressed>((event, emit) async {
      print("Forget Password Button Pressed event received");

      emit(OtpLoadingState());
      print("Emitted Forget Password Loading State");

      try {
        final response = await otpRepo.userOtp(
          email: event.email,
          otp: event.otp,
        );
        print("Response: $response");
        if (response.isLeft()) {
          final failure = response.fold((failure) => failure, (_) => null);
          print("Otp failed: $failure");
          emit(OtpFailureState(error: failure.toString()));
        } else {
          print("Otp successful");

          emit(const OtpSuccessState(message: "User Created Successfully"));
          print("Otp successful 2");
        }
      } catch (e) {
        print("Otp failed: $e");
        emit(
          OtpFailureState(
            error: e.toString(),
          ),
        );
      }
    });
  }

  @override
  void onTransition(Transition<OtpEvent, OtpState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onChange(Change<OtpState> change) {
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
  void onEvent(OtpEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
