import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Data/datasources/SignupRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/params/UserSignupInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/repositories/SignupRepository.dart';

class SignupRepositoryImple extends SignupRepository {
  final SignupRemoteDatasource remotedatasources;

  SignupRepositoryImple({required this.remotedatasources});

  @override
   Future<dynamic>UserSignup(UserSignupInput input) async {
    try {
      final remoteData = await remotedatasources.userSignup(input: input);

      return remoteData;
    } catch (error) {
     throw ServerFailure(message: error.toString());
    }
  }
}
