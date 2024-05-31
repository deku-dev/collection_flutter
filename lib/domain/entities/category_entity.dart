import 'package:floor/floor.dart';

@entity
class CategoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  CategoryEntity(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      map['id'] as int?,
      map['name'] as String,
    );
  }
}
