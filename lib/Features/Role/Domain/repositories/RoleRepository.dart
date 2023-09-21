import 'package:project_cleanarchiteture/Core/BaseRepository.dart';

 abstract class RoleRepository extends BaseRepository
{
    Future<dynamic> RoleLov({required  String token});
}