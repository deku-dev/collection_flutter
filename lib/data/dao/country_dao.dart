import 'package:floor/floor.dart';
import 'package:faker/faker.dart';
import 'package:flutter_app/domain/entities/country_entity.dart';

@dao
abstract class CountryDao {
  @Query('SELECT * FROM CountryEntity')
  Future<List<CountryEntity>> findAllCountries();

  @Query('SELECT id FROM CountryEntity')
  Future<List<int>> findAllCountriesId();

  @Query('SELECT * FROM CountryEntity WHERE id = :id')
  Future<CountryEntity?> findCountryById(int id);

  @insert
  Future<void> insertCountry(CountryEntity post);

  @update
  Future<void> updateCountry(CountryEntity post);

  @delete
  Future<void> deleteCountry(CountryEntity post);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final country = CountryEntity(null, faker.company.name());
      await insertCountry(country);
    }
  }
}