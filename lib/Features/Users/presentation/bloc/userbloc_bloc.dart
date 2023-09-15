import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Features/Users/domain/repositories/UserRepository.dart';
import 'package:project_cleanarchiteture/Features/Users/domain/response/UserLovResponse.dart';
import 'package:project_cleanarchiteture/Utils/GeneralResponse.dart';

part 'userbloc_event.dart';

part 'userbloc_state.dart';

class UserblocBloc extends Bloc<UserblocEvent, UserblocState> {
  final UserRepository repository;

  UserblocBloc({required this.repository}) : super(LoadingUserLovState()) {
    on<UserblocEvent>((event, emit) async {
      emit(LoadingUserLovState());
      try {
        await repository.UserLov(token: "dsadasd").then((value) {
          List<UserLovResponse> userlist =
              List<UserLovResponse>.empty(growable: true);
          List<CustomError> error = List<CustomError>.empty(growable: true);
          if (value["error"] != null) {
            List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
              error.add((CustomError.fromJson(
                  json.decode(json.encode(element)) as Map<String, dynamic>)));
            });
          }

          if (value["getAllUserslov"] != null) {
            List<Map<String, dynamic>>.from(value["getAllUserslov"])
                .forEach((element) {
              userlist.add((UserLovResponse.fromJson(
                  json.decode(json.encode(element)) as Map<String, dynamic>)));
            });
            var data = GeneralResponse<List<UserLovResponse>>(
              error.isNotEmpty ? error : null,
              value["getAllUserslov"] != null ? userlist : null,
            );
            emit(LoadedUserLovState(data.data!));
          }
        });
      } catch (e) {
        emit(
          ErrorUserLovState(
            e.toString(),
          ),
        );
      }
    });
  }
}
