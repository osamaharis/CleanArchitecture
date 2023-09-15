import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/CRUD/repo/users_lov_repository.dart';
import 'package:project_cleanarchiteture/Features/Users/domain/repositories/UserRepository.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/Domain/repositories/ForgetPasswordRepository.dart';

class UserLovUsecase {
  final UserRepository repository;

  UserLovUsecase({required this.repository});
  Future execute(String token) async {
    return repository.UserLov(token: token);
  }
}
