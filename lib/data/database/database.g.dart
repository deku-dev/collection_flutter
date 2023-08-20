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
            'CREATE TABLE IF NOT EXISTS `Post` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT, `year` INTEGER, `timestamp` INTEGER NOT NULL, `inStock` INTEGER, `image_urls` TEXT, `country_id` INTEGER NOT NULL, `series_id` INTEGER NOT NULL, `category_id` INTEGER NOT NULL, `type_id` INTEGER NOT NULL, FOREIGN KEY (`type_id`) REFERENCES `Type` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`series_id`) REFERENCES `Series` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`country_id`) REFERENCES `Country` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Country` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Type` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Series` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');

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
        _postInsertionAdapter = InsertionAdapter(
            database,
            'Post',
            (Post item) => <String, Object?>{
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
        _postUpdateAdapter = UpdateAdapter(
            database,
            'Post',
            ['id'],
            (Post item) => <String, Object?>{
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
        _postDeletionAdapter = DeletionAdapter(
            database,
            'Post',
            ['id'],
            (Post item) => <String, Object?>{
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

  final InsertionAdapter<Post> _postInsertionAdapter;

  final UpdateAdapter<Post> _postUpdateAdapter;

  final DeletionAdapter<Post> _postDeletionAdapter;

  @override
  Future<List<Post>> findAllPosts() async {
    return _queryAdapter.queryList('SELECT * FROM Post',
        mapper: (Map<String, Object?> row) => Post(
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
  Future<Post?> findPostById(int id) async {
    return _queryAdapter.query('SELECT * FROM Post WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Post(
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
  Future<void> insertPost(Post post) async {
    await _postInsertionAdapter.insert(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePost(Post post) async {
    await _postUpdateAdapter.update(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePost(Post post) async {
    await _postDeletionAdapter.delete(post);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'Category',
            ['id'],
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _categoryDeletionAdapter = DeletionAdapter(
            database,
            'Category',
            ['id'],
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  @override
  Future<List<Category>> findAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM Category',
        mapper: (Map<String, Object?> row) =>
            Category(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllCategoriesId() async {
    return _queryAdapter.queryList('SELECT id FROM Category',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<Category?> findCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM Category WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Category(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(category, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _categoryUpdateAdapter.update(category, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCategory(Category category) async {
    await _categoryDeletionAdapter.delete(category);
  }
}

class _$CountryDao extends CountryDao {
  _$CountryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _countryInsertionAdapter = InsertionAdapter(
            database,
            'Country',
            (Country item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _countryUpdateAdapter = UpdateAdapter(
            database,
            'Country',
            ['id'],
            (Country item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _countryDeletionAdapter = DeletionAdapter(
            database,
            'Country',
            ['id'],
            (Country item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Country> _countryInsertionAdapter;

  final UpdateAdapter<Country> _countryUpdateAdapter;

  final DeletionAdapter<Country> _countryDeletionAdapter;

  @override
  Future<List<Country>> findAllCountries() async {
    return _queryAdapter.queryList('SELECT * FROM Country',
        mapper: (Map<String, Object?> row) =>
            Country(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllCountriesId() async {
    return _queryAdapter.queryList('SELECT id FROM Country',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<Country?> findCountryById(int id) async {
    return _queryAdapter.query('SELECT * FROM Country WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Country(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertCountry(Country post) async {
    await _countryInsertionAdapter.insert(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCountry(Country post) async {
    await _countryUpdateAdapter.update(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCountry(Country post) async {
    await _countryDeletionAdapter.delete(post);
  }
}

class _$TypeDao extends TypeDao {
  _$TypeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _typeInsertionAdapter = InsertionAdapter(database, 'Type',
            (Type item) => <String, Object?>{'id': item.id, 'name': item.name}),
        _typeUpdateAdapter = UpdateAdapter(database, 'Type', ['id'],
            (Type item) => <String, Object?>{'id': item.id, 'name': item.name}),
        _typeDeletionAdapter = DeletionAdapter(database, 'Type', ['id'],
            (Type item) => <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Type> _typeInsertionAdapter;

  final UpdateAdapter<Type> _typeUpdateAdapter;

  final DeletionAdapter<Type> _typeDeletionAdapter;

  @override
  Future<List<Type>> findAllTypes() async {
    return _queryAdapter.queryList('SELECT * FROM Type',
        mapper: (Map<String, Object?> row) =>
            Type(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllTypesId() async {
    return _queryAdapter.queryList('SELECT id FROM Type',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<Type?> findTypeById(int id) async {
    return _queryAdapter.query('SELECT * FROM Type WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Type(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertType(Type type) async {
    await _typeInsertionAdapter.insert(type, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateType(Type type) async {
    await _typeUpdateAdapter.update(type, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteType(Type type) async {
    await _typeDeletionAdapter.delete(type);
  }
}

class _$SeriesDao extends SeriesDao {
  _$SeriesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _seriesInsertionAdapter = InsertionAdapter(
            database,
            'Series',
            (Series item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _seriesUpdateAdapter = UpdateAdapter(
            database,
            'Series',
            ['id'],
            (Series item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _seriesDeletionAdapter = DeletionAdapter(
            database,
            'Series',
            ['id'],
            (Series item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Series> _seriesInsertionAdapter;

  final UpdateAdapter<Series> _seriesUpdateAdapter;

  final DeletionAdapter<Series> _seriesDeletionAdapter;

  @override
  Future<List<Series>> findAllSeries() async {
    return _queryAdapter.queryList('SELECT * FROM Series',
        mapper: (Map<String, Object?> row) =>
            Series(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<List<int>> findAllSeriesId() async {
    return _queryAdapter.queryList('SELECT id FROM Series',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<Series?> findSeriesById(int id) async {
    return _queryAdapter.query('SELECT * FROM Series WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Series(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertSeries(Series series) async {
    await _seriesInsertionAdapter.insert(series, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSeries(Series series) async {
    await _seriesUpdateAdapter.update(series, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSeries(Series series) async {
    await _seriesDeletionAdapter.delete(series);
  }
}
