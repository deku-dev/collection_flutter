import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter_app/data/dao/base_dao.dart';
import 'package:flutter_app/domain/entities/series_entity.dart';

@dao
abstract class SeriesDao extends BaseDao<SeriesEntity> {
  @Query('SELECT * FROM SeriesEntity')
  Future<List<SeriesEntity>> findAllSeries();

  @Query('SELECT id FROM SeriesEntity')
  Future<List<int>> findAllSeriesId();

  @Query('SELECT * FROM SeriesEntity WHERE id = :id')
  Future<SeriesEntity?> findSeriesById(int id);

  @update
  Future<void> updateItem(SeriesEntity series);

  @delete
  Future<void> deleteItem(SeriesEntity series);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final series = SeriesEntity(null, faker.sport.name());
      await insertItem(series);
    }
  }
}