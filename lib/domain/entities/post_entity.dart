import 'dart:convert';

import 'package:Collectioneer/domain/entities/category_entity.dart';
import 'package:Collectioneer/domain/entities/country_entity.dart';
import 'package:Collectioneer/domain/entities/series_entity.dart';
import 'package:Collectioneer/domain/entities/type_entity.dart';
import 'package:floor/floor.dart';

import 'base_entity.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['type_id'],
      parentColumns: ['id'],
      entity: TypeEntity,
    ),
    ForeignKey(
      childColumns: ['category_id'],
      parentColumns: ['id'],
      entity: CategoryEntity,
    ),
    ForeignKey(
        childColumns: ['series_id'], parentColumns: ['id'], entity: SeriesEntity),
    ForeignKey(
        childColumns: ['country_id'], parentColumns: ['id'], entity: CountryEntity),
  ],
)
class PostEntity extends BaseEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  late final String title;
  late final String? description;
  final int? year;
  final int timestamp;
  final bool? inStock;

  @ColumnInfo(name: 'image_urls')
  final String? images;

  @ColumnInfo(name: 'country_id')
  final int countryId; // Foreign key field

  @ColumnInfo(name: 'series_id')
  final int seriesId; // Foreign key field

  @ColumnInfo(name: 'category_id')
  final int categoryId; // Foreign key field

  @ColumnInfo(name: 'type_id')
  final int typeId; // Foreign key field

  PostEntity({
      this.id,
      required this.title,
      this.description,
      this.images = '[]',
      required this.typeId,
      this.year,
      required this.timestamp,
      this.inStock,
      required this.countryId,
      required this.seriesId,
      required this.categoryId});

  List<String> get imageUrls {
    return json.decode(images!).cast<String>();
  }

  String get firstImage {
    return imageUrls[0] ?? '';
  }

  Future<TypeEntity?> getType() async {
    return database.typeDao.findTypeById(typeId);
  }

  Future<SeriesEntity?> getSeries() async {
    return await database.seriesDao.findSeriesById(seriesId);
  }

  Future<CategoryEntity?> getCategory() async {
    return await database.categoryDao.findCategoryById(categoryId);
  }

  Future<CountryEntity?> getCountry() async {
    return await database.countryDao.findCountryById(countryId);
  }
}
