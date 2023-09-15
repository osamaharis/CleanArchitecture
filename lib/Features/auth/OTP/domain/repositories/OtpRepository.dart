import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';

abstract class OtpRepository extends BaseRepository {
  Future<Either<Failure, String>> userOtp({
    required String otp,
    required String email,
    String? password,
  });
}
