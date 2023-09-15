import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';

abstract class CreateNewPasswordRepository extends BaseRepository {
  Future<Either<Failure, String>> userCreateNewPassword(
    String email,
    String otp,
  );
}
