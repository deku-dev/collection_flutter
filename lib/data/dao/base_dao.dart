import 'package:floor/floor.dart';

abstract class BaseDao<T> {
  @insert
  Future<void> _insertItem(T item);

  Future<void> insertItem(T item) async {
    try {
      await _insertItem(item);
    } catch (e) {
      // Handle exception
    }
  }
}