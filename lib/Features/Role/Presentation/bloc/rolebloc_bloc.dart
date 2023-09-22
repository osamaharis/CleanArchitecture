import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/Role/Domain/model/RoleResponse.dart';
import 'package:project_cleanarchiteture/Features/Role/Domain/repositories/RoleRepository.dart';
import 'package:project_cleanarchiteture/Utils/TextResources.dart';

import '../../../../Utils/GeneralResponse.dart';

part 'rolebloc_event.dart';

part 'rolebloc_state.dart';

class RoleblocBloc extends Bloc<RoleblocEvent, RoleblocState> {
  final RoleRepository repository;

  RoleblocBloc({required this.repository}) : super(LoadingRoleLovState()) {
    on<LoadedRoleLovEvent>((event, emit) async {
      try {
        emit(LoadingRoleLovState());
        await repository.RoleLov(token: event.token).then((value) {
          List<RoleResponse> rolelist =
              List<RoleResponse>.empty(growable: true);
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
              rolelist.add((RoleResponse.fromJson(
                  json.decode(json.encode(element)) as Map<String, dynamic>)));
            });
            var data = GeneralResponse<List<RoleResponse>>(
              error.isNotEmpty ? error : null,
              value["getAllRoleslov"] != null ? rolelist : null,
            );
            emit(LoadedRoleLovState(data.data!));
          }
        }).catchError((err) {
          emit(ErrorRoleLovState(
              error: (err as ServerFailure).message.toString()));
        });
      } catch (e) {
        emit(ErrorRoleLovState(  error: e.toString()));
      }
    });
  }
}
