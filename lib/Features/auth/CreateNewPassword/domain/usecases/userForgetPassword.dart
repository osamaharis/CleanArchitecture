import 'package:dartz/dartz.dart';
import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/domain/repositories/ForgetPasswordRepository.dart';

class UserCreateNewPasswordUsecase {
  final CreateNewPasswordRepository repository;

  UserCreateNewPasswordUsecase({required this.repository});
  Future<Either<Failure, String>> execute(
    String email,
    String otp,
  ) async {
    return repository.userCreateNewPassword(
      email,
      otp,
    );
  }
}
