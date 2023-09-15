import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/OTP/domain/repositories/OtpRepository.dart';

class userOtpUsecase {
  final OtpRepository repository;

  userOtpUsecase({required this.repository});
  Future<Either<Failure, String>> execute({
    required String otp,
    required String email,
    String? password,
  }) async {
    return repository.userOtp(
      email: email,
      otp: otp,
    );
  }
}
