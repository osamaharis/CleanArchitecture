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
  Future<Either<Failure, LoginAdmin>> userlogin(UserLoginInput input) async {
    try {
      final remoteData = await remotedatasources.userLogin(input: input);
      return Right(remoteData);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
