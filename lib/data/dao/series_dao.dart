import 'package:floor/floor.dart';
import 'package:flutter_app/domain/entities/series_entity.dart';
import 'package:faker/faker.dart';

@dao
abstract class SeriesDao {
  @Query('SELECT * FROM SeriesEntity')
  Future<List<SeriesEntity>> findAllSeries();

  @Query('SELECT id FROM SeriesEntity')
  Future<List<int>> findAllSeriesId();

  @Query('SELECT * FROM SeriesEntity WHERE id = :id')
  Future<SeriesEntity?> findSeriesById(int id);

  @insert
  Future<void> insertSeries(SeriesEntity series);

  @update
  Future<void> updateSeries(SeriesEntity series);

  @delete
  Future<void> deleteSeries(SeriesEntity series);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final series = SeriesEntity(null, faker.sport.name());
      await insertSeries(series);
    }
  }
}