import 'package:floor/floor.dart';
import 'package:flutter_app/entity/type.dart';
import 'package:faker/faker.dart';

@dao
abstract class TypeDao {
  @Query('SELECT * FROM Type')
  Future<List<Type>> findAllTypes();

  @Query('SELECT id FROM Type')
  Future<List<int>> findAllTypesId();

  @Query('SELECT * FROM Type WHERE id = :id')
  Future<Type?> findTypeById(int id);

  @insert
  Future<void> insertType(Type type);

  @update
  Future<void> updateType(Type type);

  @delete
  Future<void> deleteType(Type type);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final post = Type(null, faker.sport.name());
      await insertType(post);
    }
  }
}