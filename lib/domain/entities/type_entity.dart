import 'package:floor/floor.dart';

@entity
class TypeEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  TypeEntity(this.id, this.name);
}