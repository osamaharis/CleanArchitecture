import 'package:project_cleanarchiteture/Features/Role/Data/repositories/RoleRepositoryImpl.dart';

import '../repositories/RoleRepository.dart';

class RoleUsecase {
  final RoleRepository repo;
  RoleUsecase({required this.repo});
  Future execute(String token) {
    return repo.RoleLov(token: token);
  }
}
