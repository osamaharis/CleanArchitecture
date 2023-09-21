import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/params/UserLoginInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/repositories/LoginRepository.dart';
import 'package:project_cleanarchiteture/Utils/GeneralResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Core/failures.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LocalData {
  final LoginRepository loginRepo;
  var token = "";
  var ipAddress = "";

  LoginBloc({required this.loginRepo}) : super(LoginInitialState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginInitialState());

      try {
        await loginRepo.userlogin(input: event.input).then((value) {
          List<CustomError> error = List<CustomError>.empty(growable: true);
          if (value["error"] != null) {
            List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
              error.add((CustomError.fromJson(
                  json.decode(json.encode(element)) as Map<String, dynamic>)));
            });
          }

          var data = GeneralResponse<LoginAdmin>(
            error.isNotEmpty ? error : null,
            (value["loginUser"] != null)
                ? (LoginAdmin.fromJson(value["loginUser"]))
                : null,
          );
          if (data.data != null) {
            emit(LoginSuccessState(loginResponse: data.data));
            setUserinfo(jsonEncode(data.data?.toJson()));
          } else {
            emit(LoginFailureState(error: "No data Found"));
          }
        }).catchError(( err) {

          emit(LoginFailureState(error:(err as  ServerFailure).message.toString()));
        });
      } catch (e) {
        emit(LoginFailureState(error: e.toString()));
      }
    });

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
}
