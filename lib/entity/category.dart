import 'package:floor/floor.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  Category(this.id, this.name);
}
