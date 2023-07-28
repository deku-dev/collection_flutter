import 'package:floor/floor.dart';

@entity
class Series {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  Series(this.id, this.name);
}
