
import 'package:Collectioneer/domain/entities/series_entity.dart';
import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@dao
abstract class SeriesDao{
  @Query('SELECT * FROM SeriesEntity')
  Future<List<SeriesEntity>> findAllSeries();

  @Query('SELECT id FROM SeriesEntity')
  Future<List<int>> findAllSeriesId();

  @Query('SELECT * FROM SeriesEntity WHERE id = :id')
  Future<SeriesEntity?> findSeriesById(int id);

  @Query('SELECT * FROM SeriesEntity WHERE name = :name')
  Future<SeriesEntity?> findByName(String name);

  @update
  Future<void> updateItem(SeriesEntity series);

  @delete
  Future<void> deleteItem(SeriesEntity series);

  @insert
  Future<void> insertSeries(SeriesEntity item);

  Future<void> insertItem(SeriesEntity item) async {
    try {
      await insertSeries(item);
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final series = SeriesEntity(null, faker.sport.name());
      await insertItem(series);
    }
  }
}