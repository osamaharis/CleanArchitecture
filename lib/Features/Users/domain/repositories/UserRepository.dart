
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';

 abstract class UserRepository extends BaseRepository
{
   Future <dynamic>UserLov({required  String token});
   Future <dynamic> UserbyId({required String token,required int id});
}