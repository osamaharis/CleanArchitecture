

import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/params/UserLoginInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/repositories/LoginRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LocalData {
  // final userloginUsecase usecase;
  final LoginRepository loginRepo;

  LoginBloc({required this.loginRepo}) : super(LoginInitialState()) {
    on<LoginButtonPressed>((event, emit) async {
      print("LoginButtonPressed event received");

      emit(LoginLoadingState());
      print("Emitted Login Loading State");

      try {
        final response = await loginRepo.userlogin(event.input);

        print("Response: $response");

        if (response.isLeft()) {
          final failure = response.fold((failure) => failure, (_) => null);
          print("Login failed: $failure");
          emit(LoginFailureState(error: failure.toString()));
        } else {
          print("Login successful");

          emit(
            LoginSuccessState(
              message: "Logged In Successfully",
              loginResponse: (response as Right).value,
            ),
          );
          setUserinfo(jsonEncode(response));
         // _saveLoginDataToSharedPreferences(jsonEncode(response));

          print("Login successful 2");
        }
      } catch (e) {
        print("Login failed: $e");
        emit(LoginFailureState(error: e.toString()));
      }
    });
  }

//   _onloginrequest(LoginButtonPressed event, Emitter<LoginState> emit) async {
//     emit(LoginLoading());
//
//     final result = await usecase.execute(event.input);
// emit(result)
  // @override
  // Stream<LoginState> mapEventToState(LoginButtonPressed btnevent) async* {
  //   if (btnevent is LoginButtonPressed) {
  //     yield LoginLoadingState();
  //     try {
  //       final response = await loginrepo.Userlogin(UserLoginInput(
  //           email: btnevent.input.email,
  //           password: btnevent.input.password,
  //           deviceId: btnevent.input.deviceId,
  //           loginIp: btnevent.input.loginIp));
  //       yield LoginSuccessState(message: "Logged In Successfully");
  //     } catch (e) {}
  //   }
  // }
  //
  //
  // @override
  // LoginState get initialState => LoginInitialState();
  // @override
  // Stream<LoginState> mapEventToState(
  //   LoginState currentState,
  //   LoginEvent event,
  // ) async* {
  //   if (event is LoginButtonPressed) {
  //     yield LoginLoadingState();
  //     try {
  //       final response = await loginRepo.userlogin(event.input);
  //       yield LoginSuccessState(message: "Logged In Successfully");
  //     } catch (e) {
  //       yield LoginFailureState(error: e.toString());
  //     }
  //   }
  // }

  // Future<void> _saveLoginDataToSharedPreferences(String loginData) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('loginData', loginData);
  // }
  //
  // // var savedLoginData;
  // Future<void> _getSavedLoginData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final loginData = prefs.getString('loginData');
  //   // setState(() {
  //   //   savedLoginData = loginData;
  //   // });
  // }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onChange(Change<LoginState> change) {
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
  void onEvent(LoginEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
