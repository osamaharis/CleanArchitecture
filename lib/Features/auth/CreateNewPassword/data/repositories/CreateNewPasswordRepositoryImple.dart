import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/data/datasources/CreateNewPasswordRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/domain/repositories/ForgetPasswordRepository.dart';

class CreateNewPasswordRepositoryImple extends CreateNewPasswordRepository {
  final CreateNewPasswordRemoteDatasource remotedatasources;

  CreateNewPasswordRepositoryImple({required this.remotedatasources});

  @override
  Future<Either<Failure, String>> userCreateNewPassword(
    String email,
    String otp,
  ) async {
    try {
      final remoteData = await remotedatasources.userCreateNewPassword(
        email: email,
        otp: otp,
      );

      print("Repo Result: $remoteData");

      return Right(remoteData);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
