import 'package:floor/floor.dart';

@entity
class SeriesEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  SeriesEntity(this.id, this.name);
}
