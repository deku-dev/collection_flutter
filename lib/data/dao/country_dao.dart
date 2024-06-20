import 'package:Collectioneer/domain/entities/country_entity.dart';
import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';


@dao
abstract class CountryDao {
  @Query('SELECT * FROM CountryEntity')
  Future<List<CountryEntity>> findAllCountries();

  @Query('SELECT id FROM CountryEntity')
  Future<List<int>> findAllCountriesId();

  @Query('SELECT * FROM CountryEntity WHERE id = :id')
  Future<CountryEntity?> findCountryById(int id);

  @Query('SELECT * FROM CountryEntity WHERE name = :name')
  Future<CountryEntity?> findByName(String name);

  @update
  Future<void> updateItem(CountryEntity post);

  @delete
  Future<void> deleteItem(CountryEntity post);

  @insert
  Future<void> insertCountry(CountryEntity item);

  Future<void> insertItem(CountryEntity item) async {
    try {
      await insertCountry(item);
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final country = CountryEntity(null, faker.company.name());
      await insertItem(country);
    }
  }
}