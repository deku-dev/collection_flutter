import 'package:floor/floor.dart';
import 'package:flutter_app/entity/country.dart';
import 'package:faker/faker.dart';

@dao
abstract class CountryDao {
  @Query('SELECT * FROM Country')
  Future<List<Country>> findAllCountries();

  @Query('SELECT id FROM Country')
  Future<List<int>> findAllCountriesId();

  @Query('SELECT * FROM Country WHERE id = :id')
  Future<Country?> findCountryById(int id);

  @insert
  Future<void> insertCountry(Country post);

  @update
  Future<void> updateCountry(Country post);

  @delete
  Future<void> deleteCountry(Country post);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final post = Country(null, faker.company.name());
      await insertCountry(post);
    }
  }
}