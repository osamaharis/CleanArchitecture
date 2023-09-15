import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/params/UserLoginInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/repositories/LoginRepository.dart';

import '../entities/AdminSignInResponse.dart';

class userloginUsecase {
  final LoginRepository repository;

  userloginUsecase({required this.repository});
  Future<Either<Failure, LoginAdmin>> execute(UserLoginInput userLogin) async {
    return repository.userlogin(userLogin);
  }
}
