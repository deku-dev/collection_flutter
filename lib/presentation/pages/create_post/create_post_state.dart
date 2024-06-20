import 'package:equatable/equatable.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/entities/series_entity.dart';
import '../../../domain/entities/type_entity.dart';

class CreatePostFormState extends Equatable {
  final PostEntity? post;
  final String title;
  final String description;
  final bool inStock;
  final int? year;
  final int? selectedTypeId;
  final int? selectedCategoryId;
  final int? selectedSeriesId;
  final int? selectedCountryId;
  final List<String> imageUrls;
  final List<TypeEntity> types;
  final List<CategoryEntity> categories;
  final List<SeriesEntity> series;
  final List<CountryEntity> countries;

  const CreatePostFormState({
    this.post,
    required this.title,
    required this.description,
    required this.inStock,
    required this.year,
    required this.selectedTypeId,
    required this.selectedCategoryId,
    required this.selectedSeriesId,
    required this.selectedCountryId,
    required this.imageUrls,
    required this.types,
    required this.categories,
    required this.series,
    required this.countries,
  });

  factory CreatePostFormState.initial(PostEntity? post) {
    return CreatePostFormState(
      post: post,
      title: post?.title ?? '',
      description: post?.description ?? '',
      inStock: post?.inStock ?? false,
      year: post?.year,
      selectedTypeId: post?.typeId,
      selectedCategoryId: post?.categoryId,
      selectedSeriesId: post?.seriesId,
      selectedCountryId: post?.countryId,
      imageUrls: post?.imageUrls ?? [],
      types: const [],
      categories: const [],
      series: const [],
      countries: const [],
    );
  }

  CreatePostFormState copyWith({
    String? title,
    String? description,
    bool? inStock,
    int? year,
    int? selectedTypeId,
    int? selectedCategoryId,
    int? selectedSeriesId,
    int? selectedCountryId,
    List<String>? imageUrls,
    List<TypeEntity>? types,
    List<CategoryEntity>? categories,
    List<SeriesEntity>? series,
    List<CountryEntity>? countries,
  }) {
    return CreatePostFormState(
      post: post,
      title: title ?? this.title,
      description: description ?? this.description,
      inStock: inStock ?? this.inStock,
      year: year ?? this.year,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedSeriesId: selectedSeriesId ?? this.selectedSeriesId,
      selectedCountryId: selectedCountryId ?? this.selectedCountryId,
      imageUrls: imageUrls ?? this.imageUrls,
      types: types ?? this.types,
      categories: categories ?? this.categories,
      series: series ?? this.series,
      countries: countries ?? this.countries,
    );
  }

  @override
  List<Object?> get props => [
    post,
    title,
    description,
    inStock,
    year,
    selectedTypeId,
    selectedCategoryId,
    selectedSeriesId,
    selectedCountryId,
    imageUrls,
    types,
    categories,
    series,
    countries,
  ];
}
