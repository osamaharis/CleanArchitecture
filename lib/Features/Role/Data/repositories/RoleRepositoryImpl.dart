import 'package:project_cleanarchiteture/Core/failures.dart';
import 'package:project_cleanarchiteture/Features/Role/Data/datasource/RoleDataSource.dart';
import 'package:project_cleanarchiteture/Features/Role/Domain/repositories/RoleRepository.dart';

class RoleRepositoryImpl extends RoleRepository {
  RoleRepositoryImpl({required this.dataSource});

  final RoleDataSource dataSource;

  @override
  RoleLov({required String token}) async {
    try {
      final remote = await dataSource.RoleLov(token: token);
      return remote;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
