import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/params/UserSignupInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/repositories/SignupRepository.dart';

class userSignupUsecase {
  final SignupRepository repository;

  userSignupUsecase({required this.repository});
execute(UserSignupInput userSignup) async {
    return repository.UserSignup(userSignup);
  }
}
