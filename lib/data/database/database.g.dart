// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PostDao? _postDaoInstance;

  CategoryDao? _categoryDaoInstance;

  CountryDao? _countryDaoInstance;

  TypeDao? _typeDaoInstance;

  SeriesDao? _seriesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PostEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT, `year` INTEGER, `timestamp` INTEGER NOT NULL, `inStock` INTEGER, `image_urls` TEXT, `country_id` INTEGER NOT NULL, `series_id` INTEGER NOT NULL, `category_id` INTEGER NOT NULL, `type_id` INTEGER NOT NULL, FOREIGN KEY (`type_id`) REFERENCES `TypeEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`category_id`) REFERENCES `CategoryEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`series_id`) REFERENCES `SeriesEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`country_id`) REFERENCES `CountryEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CategoryEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CountryEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TypeEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SeriesEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PostDao get postDao {
    return _postDaoInstance ??= _$PostDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  CountryDao get countryDao {
    return _countryDaoInstance ??= _$CountryDao(database, changeListener);
  }

  @override
  TypeDao get typeDao {
    return _typeDaoInstance ??= _$TypeDao(database, changeListener);
  }

  @override
  SeriesDao get seriesDao {
    return _seriesDaoInstance ??= _$SeriesDao(database, changeListener);
  }
}

class _$PostDao extends PostDao {
  _$PostDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _postEntityInsertionAdapter = InsertionAdapter(
            database,
            'PostEntity',
            (PostEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'year': item.year,
                  'timestamp': item.timestamp,
                  'inStock':
                      item.inStock == null ? null : (item.inStock! ? 1 : 0),
                  'image_urls': item.images,
                  'country_id': item.countryId,
                  'series_id': item.seriesId,
                  'category_id': item.categoryId,
                  'type_id': item.typeId
                }),
        _postEntityUpdateAdapter = UpdateAdapter(
            database,
            'PostEntity',
            ['id'],
            (PostEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'year': item.year,
                  'timestamp': item.timestamp,
                  'inStock':
                      item.inStock == null ? null : (item.inStock! ? 1 : 0),
                  'image_urls': item.images,
                  'country_id': item.countryId,
                  'series_id': item.seriesId,
                  'category_id': item.categoryId,
                  'type_id': item.typeId
                }),
        _postEntityDeletionAdapter = DeletionAdapter(
            database,
            'PostEntity',
            ['id'],
            (PostEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'year': item.year,
                  'timestamp': item.timestamp,
                  'inStock':
                      item.inStock == null ? null : (item.inStock! ? 1 : 0),
                  'image_urls': item.images,
                  'country_id': item.countryId,
                  'series_id': item.seriesId,
                  'category_id': item.categoryId,
                  'type_id': item.typeId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PostEntity> _postEntityInsertionAdapter;

  final UpdateAdapter<PostEntity> _postEntityUpdateAdapter;

  final DeletionAdapter<PostEntity> _postEntityDeletionAdapter;

  @override
  Future<List<PostEntity>> findAllPosts() async {
    return _queryAdapter.queryList(
        'SELECT * FROM PostEntity ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => PostEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String?,
            images: row['image_urls'] as String?,
            typeId: row['type_id'] as int,
            year: row['year'] as int?,
            timestamp: row['timestamp'] as int,
            inStock:
                row['inStock'] == null ? null : (row['inStock'] as int) != 0,
            countryId: row['country_id'] as int,
            seriesId: row['series_id'] as int,
            categoryId: row['category_id'] as int));
  }

  @override
  Future<List<PostEntity>> findPostByCategory(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PostEntity WHERE category_id = ?1 ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => PostEntity(id: row['id'] as int?, title: row['title'] as String, description: row['description'] as String?, images: row['image_urls'] as String?, typeId: row['type_id'] as int, year: row['year'] as int?, timestamp: row['timestamp'] as int, inStock: row['inStock'] == null ? null : (row['inStock'] as int) != 0, countryId: row['country_id'] as int, seriesId: row['series_id'] as int, categoryId: row['category_id'] as int),
        arguments: [id]);
  }

  @override
  Future<PostEntity?> findPostById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM PostEntity WHERE id = ?1 ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => PostEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String?,
            images: row['image_urls'] as String?,
            typeId: row['type_id'] as int,
            year: row['year'] as int?,
            timestamp: row['timestamp'] as int,
            inStock:
                row['inStock'] == null ? null : (row['inStock'] as int) != 0,
            countryId: row['country_id'] as int,
            seriesId: row['series_id'] as int,
            categoryId: row['category_id'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertPost(PostEntity post) async {
    await _postEntityInsertionAdapter.insert(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePost(PostEntity post) async {
    await _postEntityUpdateAdapter.update(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    await _postEntityDeletionAdapter.delete(post);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'CategoryEntity',
            (CategoryEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _categoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'CategoryEntity',
            ['id'],
            (CategoryEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _categoryEntityDeletionAdapter = DeletionAdapter(
            database,
            'CategoryEntity',
            ['id'],
            (CategoryEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryEntity> _categoryEntityInsertionAdapter;

  final UpdateAdapter<CategoryEntity> _categoryEntityUpdateAdapter;

  final DeletionAdapter<CategoryEntity> _categoryEntityDeletionAdapter;

  @override
  Future<List<CategoryEntity>> findAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM CategoryEntity',
        mapper: (Map<String, Object?> row) =>
            CategoryEntity(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllCategoriesId() async {
    return _queryAdapter.queryList('SELECT id FROM CategoryEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<CategoryEntity?> findCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM CategoryEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            CategoryEntity(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> _insertItem(CategoryEntity item) async {
    await _categoryEntityInsertionAdapter.insert(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateItem(CategoryEntity category) async {
    await _categoryEntityUpdateAdapter.update(
        category, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteItem(CategoryEntity category) async {
    await _categoryEntityDeletionAdapter.delete(category);
  }
}

class _$CountryDao extends CountryDao {
  _$CountryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _countryEntityInsertionAdapter = InsertionAdapter(
            database,
            'CountryEntity',
            (CountryEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _countryEntityUpdateAdapter = UpdateAdapter(
            database,
            'CountryEntity',
            ['id'],
            (CountryEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _countryEntityDeletionAdapter = DeletionAdapter(
            database,
            'CountryEntity',
            ['id'],
            (CountryEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CountryEntity> _countryEntityInsertionAdapter;

  final UpdateAdapter<CountryEntity> _countryEntityUpdateAdapter;

  final DeletionAdapter<CountryEntity> _countryEntityDeletionAdapter;

  @override
  Future<List<CountryEntity>> findAllCountries() async {
    return _queryAdapter.queryList('SELECT * FROM CountryEntity',
        mapper: (Map<String, Object?> row) =>
            CountryEntity(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllCountriesId() async {
    return _queryAdapter.queryList('SELECT id FROM CountryEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<CountryEntity?> findCountryById(int id) async {
    return _queryAdapter.query('SELECT * FROM CountryEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            CountryEntity(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> _insertItem(CountryEntity item) async {
    await _countryEntityInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateItem(CountryEntity post) async {
    await _countryEntityUpdateAdapter.update(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteItem(CountryEntity post) async {
    await _countryEntityDeletionAdapter.delete(post);
  }
}

class _$TypeDao extends TypeDao {
  _$TypeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _typeEntityInsertionAdapter = InsertionAdapter(
            database,
            'TypeEntity',
            (TypeEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _typeEntityUpdateAdapter = UpdateAdapter(
            database,
            'TypeEntity',
            ['id'],
            (TypeEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _typeEntityDeletionAdapter = DeletionAdapter(
            database,
            'TypeEntity',
            ['id'],
            (TypeEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TypeEntity> _typeEntityInsertionAdapter;

  final UpdateAdapter<TypeEntity> _typeEntityUpdateAdapter;

  final DeletionAdapter<TypeEntity> _typeEntityDeletionAdapter;

  @override
  Future<List<TypeEntity>> findAllTypes() async {
    return _queryAdapter.queryList('SELECT * FROM TypeEntity',
        mapper: (Map<String, Object?> row) =>
            TypeEntity(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllTypesId() async {
    return _queryAdapter.queryList('SELECT id FROM TypeEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<TypeEntity?> findTypeById(int id) async {
    return _queryAdapter.query('SELECT * FROM TypeEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            TypeEntity(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> _insertItem(TypeEntity item) async {
    await _typeEntityInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateItem(TypeEntity type) async {
    await _typeEntityUpdateAdapter.update(type, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteItem(TypeEntity type) async {
    await _typeEntityDeletionAdapter.delete(type);
  }
}

class _$SeriesDao extends SeriesDao {
  _$SeriesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _seriesEntityInsertionAdapter = InsertionAdapter(
            database,
            'SeriesEntity',
            (SeriesEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _seriesEntityUpdateAdapter = UpdateAdapter(
            database,
            'SeriesEntity',
            ['id'],
            (SeriesEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _seriesEntityDeletionAdapter = DeletionAdapter(
            database,
            'SeriesEntity',
            ['id'],
            (SeriesEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SeriesEntity> _seriesEntityInsertionAdapter;

  final UpdateAdapter<SeriesEntity> _seriesEntityUpdateAdapter;

  final DeletionAdapter<SeriesEntity> _seriesEntityDeletionAdapter;

  @override
  Future<List<SeriesEntity>> findAllSeries() async {
    return _queryAdapter.queryList('SELECT * FROM SeriesEntity',
        mapper: (Map<String, Object?> row) =>
            SeriesEntity(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllSeriesId() async {
    return _queryAdapter.queryList('SELECT id FROM SeriesEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<SeriesEntity?> findSeriesById(int id) async {
    return _queryAdapter.query('SELECT * FROM SeriesEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            SeriesEntity(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> _insertItem(SeriesEntity item) async {
    await _seriesEntityInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateItem(SeriesEntity series) async {
    await _seriesEntityUpdateAdapter.update(series, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteItem(SeriesEntity series) async {
    await _seriesEntityDeletionAdapter.delete(series);
  }
}
