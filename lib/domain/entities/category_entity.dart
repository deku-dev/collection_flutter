import 'package:floor/floor.dart';

@entity
class CategoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  CategoryEntity(this.id, this.name);
}
