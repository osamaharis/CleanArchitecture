import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Features/CRUD/repo/RoleLovResponseModel.dart';
import 'package:project_cleanarchiteture/Features/CRUD/repo/UserLovResponseModel.dart';
import 'package:project_cleanarchiteture/Features/CRUD/repo/roles_lov_repository.dart';
import 'package:project_cleanarchiteture/Features/CRUD/repo/users_lov_repository.dart';
import 'package:project_cleanarchiteture/Utils/GeneralResponse.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<LovEvent, UserState> with LocalData {
  final RoleLovRepository roleLovRepo;
  final UserLovRepository userLovRepo;

  UserBloc({
    required this.roleLovRepo,
    required this.userLovRepo,
  }) : super(RoleLovLoadingState()) {
    on<LoadRoleLovEvent>((event, emit) async {
      emit(RoleLovLoadingState());
      try {
        await roleLovRepo.roleLov(token: "wqwq").then((value) {
          List<RoleLovResponse> rolelist =
              List<RoleLovResponse>.empty(growable: true);
          List<CustomError> error = List<CustomError>.empty(growable: true);
          if (value["error"] != null) {
            List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
              error.add((CustomError.fromJson(
                  json.decode(json.encode(element)) as Map<String, dynamic>)));
            });
          }
          if (value["getAllRoleslov"] != null) {
            List<Map<String, dynamic>>.from(value["getAllRoleslov"])
                .forEach((element) {
              rolelist.add((RoleLovResponse.fromJson(
                  json.decode(json.encode(element)) as Map<String, dynamic>)));
            });
            var data = GeneralResponse<List<RoleLovResponse>>(
              error.isNotEmpty ? error : null,
              value["getAllRoleslov"] != null ? rolelist : null,
            );

            emit(RoleLovLoadedState(data.data!));
          }
        });
      } catch (e) {
        emit(RoleLovErrorState(e.toString()));
      }

    });
    on<LoadUserLovEvent>(loadUserLovEvent);

  }

  // FutureOr<void> loadRoleLovEvent(
  //   LoadRoleLovEvent event,
  //   Emitter<UserState> emit,
  // ) async {
  //   print("role Button Pressed event received");
  //
  //   emit(RoleLovLoadingState());
  //   print("Emitted role Loading State");
  //
  //   try {
  //     await roleLovRepo.roleLov(token: "wqwq").then((value) {
  //       List<RoleLovResponse> rolelist =
  //           List<RoleLovResponse>.empty(growable: true);
  //       List<CustomError> error = List<CustomError>.empty(growable: true);
  //       if (value["error"] != null) {
  //         List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
  //           error.add((CustomError.fromJson(
  //               json.decode(json.encode(element)) as Map<String, dynamic>)));
  //         });
  //       }
  //
  //       if (value["getAllRoleslov"] != null) {
  //         List<Map<String, dynamic>>.from(value["getAllRoleslov"])
  //             .forEach((element) {
  //           rolelist.add((RoleLovResponse.fromJson(
  //               json.decode(json.encode(element)) as Map<String, dynamic>)));
  //         });
  //         var data = GeneralResponse<List<RoleLovResponse>>(
  //           error.isNotEmpty ? error : null,
  //           value["getAllRoleslov"] != null ? rolelist : null,
  //         );
  //
  //         print("role loading successful");
  //
  //         emit(RoleLovLoadedState(data.data!));
  //         // emit(
  //         //   RoleLovLoadedState(
  //         //     message: "loaded Successfully",
  //         //     listOfRoles: data.data!,
  //         //   ),
  //         // );
  //
  //         print("role loading successful 2");
  //
  //         // if (data.data != null) {
  //         //   listOfRoles = data.data!;
  //         // } else {
  //         //   listOfRoles = [];
  //         // }
  //       }
  //     });
  //   } catch (e) {
  //     // listOfRoles = [];
  //     print("role loading failed: $e");
  //     emit(RoleLovErrorState(e.toString()));
  //     // emit(
  //     //   RoleLovErrorState(
  //     //     error: e.toString(),
  //     //   ),
  //     // );
  //   }
  // }

  FutureOr<void> loadUserLovEvent(
    LoadUserLovEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLovLoadingState());

    try {
      await userLovRepo.userLov(token: "wqwq").then((value) {
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
          emit(UserLovLoadedState(data.data!));
        }
      });


    } catch (e) {
      emit(
        UserLovErrorState(
          e.toString(),
        ),
      );
    }
  }

  // FutureOr<void> loadEvent(
  //     LoadRoleLovEvent event, Emitter<UserState> emit) async {
  //   print("load User Button Pressed event received");
  //   emit(LoadingState());
  //   print("Emitted User Loading State");
  //   try {
  //     final response = await roleLovRepo.roleLov(token: "wqwq").then((value) {
  //       List<UserLovResponse> rolelist =
  //           List<UserLovResponse>.empty(growable: true);
  //       List<CustomError> error = List<CustomError>.empty(growable: true);
  //       if (value["error"] != null) {
  //         List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
  //           error.add((CustomError.fromJson(
  //               json.decode(json.encode(element)) as Map<String, dynamic>)));
  //         });
  //       }
  //       if (value["getAllUserslov"] != null) {
  //         List<Map<String, dynamic>>.from(value["getAllUserslov"])
  //             .forEach((element) {
  //           rolelist.add((UserLovResponse.fromJson(
  //               json.decode(json.encode(element)) as Map<String, dynamic>)));
  //         });
  //         var data = GeneralResponse<List<UserLovResponse>>(
  //           error.isNotEmpty ? error : null,
  //           value["getAllUserslov"] != null ? rolelist : null,
  //         );
  //         print("User loading successful");
  //         emit(LoadedState(
  //           message: "loaded user Successfully",
  //           listOfUsers: data.data!,
  //           listOfRoles: data.data!,
  //         ));
  //         print("User loading successful 2");
  //         // if (data.data != null) {
  //         //   listOfUsers = data.data!;
  //         // } else {
  //         //   listOfUsers = [];
  //         // }
  //       }
  //     });
  //     // print("Response: $response");
  //   } catch (e) {
  //     // listOfUsers = [];
  //     print("User loading failed: $e");
  //     emit(
  //       ErrorState(
  //         error: e.toString(),
  //       ),
  //     );
  //   }
  // }

  @override
  void onTransition(Transition<LovEvent, UserState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onChange(Change<UserState> change) {
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
  void onEvent(LovEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
