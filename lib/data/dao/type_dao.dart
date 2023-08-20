import 'package:floor/floor.dart';
import 'package:flutter_app/domain/entities/type_entity.dart';
import 'package:faker/faker.dart';

@dao
abstract class TypeDao {
  @Query('SELECT * FROM TypeEntity')
  Future<List<TypeEntity>> findAllTypes();

  @Query('SELECT id FROM TypeEntity')
  Future<List<int>> findAllTypesId();

  @Query('SELECT * FROM TypeEntity WHERE id = :id')
  Future<TypeEntity?> findTypeById(int id);

  @insert
  Future<void> insertType(TypeEntity type);

  @update
  Future<void> updateType(TypeEntity type);

  @delete
  Future<void> deleteType(TypeEntity type);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final type = TypeEntity(null, faker.sport.name());
      await insertType(type);
    }
  }
}