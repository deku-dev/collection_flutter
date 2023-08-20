import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/series_entity.dart';
import '../../../domain/entities/type_entity.dart';

class CreatePostFormState {
  final String title;
  final String description;
  final String inStock;
  final String year;
  final int? selectedTypeId;
  final int? selectedCategoryId;
  final int? selectedSeriesId;

  final List<TypeEntity> types;
  final List<CategoryEntity> categories;
  final List<SeriesEntity> series;

  CreatePostFormState({
    this.title = '',
    this.description = '',
    this.inStock = '',
    this.year = '',
    this.selectedTypeId,
    this.selectedCategoryId,
    this.selectedSeriesId,
    this.types = const [],
    this.categories = const [],
    this.series = const [],
  });

  CreatePostFormState copyWith({
    String? title,
    String? description,
    String? inStock,
    String? year,
    int? selectedTypeId,
    int? selectedCategoryId,
    int? selectedSeriesId,
    List<TypeEntity>? types,
    List<CategoryEntity>? categories,
    List<SeriesEntity>? series,
  }) {
    return CreatePostFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      inStock: inStock ?? this.inStock,
      year: year ?? this.year,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedSeriesId: selectedSeriesId ?? this.selectedSeriesId,
      types: types ?? this.types,
      categories: categories ?? this.categories,
      series: series ?? this.series,
    );
  }
}