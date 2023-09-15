import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/Users/data/datasources/UserDataSource.dart';
import 'package:project_cleanarchiteture/Features/Users/domain/repositories/UserRepository.dart';

class UserRepositoryImplementation extends UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImplementation({required this.userDataSource});

  @override
  UserLov({required String token}) async {
    try {
      final remote = await userDataSource.UserLov(token: token);
      return remote;
    } catch (e) {
      ServerFailure(message: e.toString());
    }
  }
}
