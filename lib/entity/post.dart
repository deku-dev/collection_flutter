import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/entity/base_entity.dart';

import 'category.dart' as category;
import 'country.dart';
import 'series.dart';
import 'type.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['type_id'],
      parentColumns: ['id'],
      entity: Type,
    ),
    ForeignKey(
      childColumns: ['category_id'],
      parentColumns: ['id'],
      entity: Category,
    ),
    ForeignKey(
        childColumns: ['series_id'], parentColumns: ['id'], entity: Series),
    ForeignKey(
        childColumns: ['country_id'], parentColumns: ['id'], entity: Country),
  ],
)
class Post extends BaseEntity {
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

  Post({
      this.id,
      required this.title,
      this.description,
      this.images,
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

  Future<Type?> getType() async {
    return database.typeDao.findTypeById(typeId);
  }

  Future<Series?> getSeries() async {
    return await database.seriesDao.findSeriesById(seriesId);
  }

  Future<category.Category?> getCategory() async {
    return await database.categoryDao.findCategoryById(categoryId);
  }

  Future<Country?> getCountry() async {
    return await database.countryDao.findCountryById(countryId);
  }
}
