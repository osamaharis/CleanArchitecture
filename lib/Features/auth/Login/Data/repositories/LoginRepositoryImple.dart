import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Data/datasource/LoginRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/params/UserLoginInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/repositories/LoginRepository.dart';

class LoginRepositoryImple extends LoginRepository {
  final LoginRemoteDatasource remotedatasources;

  LoginRepositoryImple({required this.remotedatasources});

  @override
  Future<dynamic> userlogin({required UserLoginInput input}) async {
    try {
           final remoteData = await remotedatasources.userLogin(input: input);
           return remoteData;
         } catch (error) {

           throw ServerFailure(message: error.toString());
         }
       }
  }


 // (UserLoginInput input) async {
 //
