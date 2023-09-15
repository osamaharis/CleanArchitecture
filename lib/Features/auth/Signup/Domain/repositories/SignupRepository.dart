import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/params/UserSignupInput.dart';

abstract class SignupRepository extends BaseRepository {
  Future<Either<Failure, String>> userSignup(UserSignupInput userSignup);
}
