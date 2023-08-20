import 'package:floor/floor.dart';

@entity
class CountryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  CountryEntity(this.id, this.name);
}