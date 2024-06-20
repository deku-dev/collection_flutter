import 'package:floor/floor.dart';

import '../../domain/entities/user_entity.dart';


@dao
abstract class UserDao {
  @Query('SELECT * FROM User WHERE username = :username AND password = :password')
  Future<UserEntity?> login(String username, String password);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(UserEntity user);
}
