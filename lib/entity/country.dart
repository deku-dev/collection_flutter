import 'package:floor/floor.dart';

@entity
class Country {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  Country(this.id, this.name);
}