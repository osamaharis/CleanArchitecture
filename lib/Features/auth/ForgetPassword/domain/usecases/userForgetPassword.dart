import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/Domain/repositories/ForgetPasswordRepository.dart';

class userForgetPasswordUsecase {
  final ForgetPasswordRepository repository;

  userForgetPasswordUsecase({required this.repository});
  Future execute(String email) async {
    return repository.forget(email);
  }
}
