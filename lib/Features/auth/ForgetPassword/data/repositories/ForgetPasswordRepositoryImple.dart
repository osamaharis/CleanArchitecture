import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/Domain/repositories/ForgetPasswordRepository.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/data/datasources/ForgetPasswordRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Utils/TextResources.dart';

class ForgetPasswordRepositoryImple extends ForgetPasswordRepository {
  final ForgetPasswordRemoteDatasource remotedatasources;

  ForgetPasswordRepositoryImple({required this.remotedatasources});

  @override
  Future forget(String useremail) async {
    try {
      final remote = await remotedatasources.forget(email: useremail);
      return remote;
    } catch (e) {
      return ServerFailure(message: e.toString());
    }
  }









  // @override
  // Future<Either<Failure, String>> userForgetPassword(String email) async {
  //   try {
  //     final remoteData =
  //         await remotedatasources.userForgetPassword(email: email);
  //
  //     print("Repo Result: $remoteData");
  //
  //     return Right(remoteData);
  //   } catch (error) {
  //     return Left(ServerFailure(message: error.toString()));
  //   }
  // }
}
