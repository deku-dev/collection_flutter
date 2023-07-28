import 'package:floor/floor.dart';
import 'package:flutter_app/entity/series.dart';
import 'package:faker/faker.dart';

@dao
abstract class SeriesDao {
  @Query('SELECT * FROM Series')
  Future<List<Series>> findAllSeries();

  @Query('SELECT id FROM Series')
  Future<List<int>> findAllSeriesId();

  @Query('SELECT * FROM Series WHERE id = :id')
  Future<Series?> findSeriesById(int id);

  @insert
  Future<void> insertSeries(Series series);

  @update
  Future<void> updateSeries(Series series);

  @delete
  Future<void> deleteSeries(Series series);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final series = Series(null, faker.sport.name());
      await insertSeries(series);
    }
  }
}