import 'package:floor/floor.dart';

@entity
class UserEntity {
  @primaryKey
  final int id;
  final String username;
  final String password;
  final String email;
  final int timestamp;

  UserEntity(this.id, this.username, this.password, this.email, this.timestamp);
}
