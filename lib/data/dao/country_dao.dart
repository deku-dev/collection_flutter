import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter_app/domain/entities/country_entity.dart';

import 'base_dao.dart';

@dao
abstract class CountryDao extends BaseDao<CountryEntity>{
  @Query('SELECT * FROM CountryEntity')
  Future<List<CountryEntity>> findAllCountries();

  @Query('SELECT id FROM CountryEntity')
  Future<List<int>> findAllCountriesId();

  @Query('SELECT * FROM CountryEntity WHERE id = :id')
  Future<CountryEntity?> findCountryById(int id);

  @update
  Future<void> updateItem(CountryEntity post);

  @delete
  Future<void> deleteItem(CountryEntity post);


  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final country = CountryEntity(null, faker.company.name());
      await insertItem(country);
    }
  }
}