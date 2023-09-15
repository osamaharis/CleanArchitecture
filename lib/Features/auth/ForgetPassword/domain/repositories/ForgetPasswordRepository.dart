import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';

abstract class ForgetPasswordRepository extends BaseRepository {
  // Future<Either<Failure, String>> UserForgetPassword(String email);

  forget(String email) {
  }
}
