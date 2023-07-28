import 'package:floor/floor.dart';

@entity
class Type {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  Type(this.id, this.name);
}