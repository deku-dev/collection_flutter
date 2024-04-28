import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/entities/series_entity.dart';
import '../../../domain/entities/type_entity.dart';

class CreatePostFormState {
  final String title;
  final String description;

  final int? year;
  final int? selectedTypeId;
  final int? selectedCategoryId;
  final int? selectedSeriesId;
  final int? selectedCountryId;

  final bool inStock;

  final List<TypeEntity> types;
  final List<CategoryEntity> categories;
  final List<SeriesEntity> series;
  final List<CountryEntity> countries;

  final List<String> imageUrls;

  CreatePostFormState({
    this.title = '',
    this.description = '',
    this.inStock = false,
    this.year,
    this.selectedTypeId,
    this.selectedCategoryId,
    this.selectedSeriesId,
    this.selectedCountryId,
    this.types = const [],
    this.categories = const [],
    this.series = const [],
    this.countries = const [],
    this.imageUrls = const [],
  });

  CreatePostFormState copyWith({
    String? title,
    String? description,
    bool? inStock,
    int? year,
    int? selectedTypeId,
    int? selectedCategoryId,
    int? selectedSeriesId,
    int? selectedCountryId,
    List<TypeEntity>? types,
    List<CategoryEntity>? categories,
    List<SeriesEntity>? series,
    List<CountryEntity>? countries,
    List<String>? imageUrls,
  }) {
    return CreatePostFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      inStock: inStock ?? this.inStock,
      year: year ?? this.year,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedSeriesId: selectedSeriesId ?? this.selectedSeriesId,
      selectedCountryId: selectedCountryId ?? this.selectedCountryId,
      types: types ?? this.types,
      categories: categories ?? this.categories,
      series: series ?? this.series,
      countries: countries ?? this.countries,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}