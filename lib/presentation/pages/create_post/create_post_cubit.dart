import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/entities/series_entity.dart';
import '../../../domain/entities/type_entity.dart';
import '../../routes.dart';
import '../home/home_cubit.dart';
import 'create_post_state.dart';

class CreatePostFormCubit extends Cubit<CreatePostFormState> {
  final PostEntity? post;

  CreatePostFormCubit(this.post) : super(CreatePostFormState.initial(post));

  void loadPostData() {
    if (post != null) {
      emit(state.copyWith(
        title: post!.title,
        description: post!.description,
        year: post!.year,
        selectedTypeId: post!.typeId,
        selectedCategoryId: post!.categoryId,
        selectedSeriesId: post!.seriesId,
        selectedCountryId: post!.countryId,
        imageUrls: post!.imageUrls,
        inStock: post!.inStock,
      ));
      updateSeries();
      updateCategories();
      updateCountries();
      updateTypes();
    }
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateYear(int year) {
    emit(state.copyWith(year: year));
  }

  void updateSelectedType(int typeId) {
    emit(state.copyWith(selectedTypeId: typeId));
  }

  void updateSelectedCategory(int categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
  }

  void updateSelectedSeries(int seriesId) {
    emit(state.copyWith(selectedSeriesId: seriesId));
  }

  void updateSelectedCountry(int countryId) {
    emit(state.copyWith(selectedCountryId: countryId));
  }

  void updateInStock(bool inStock) {
    emit(state.copyWith(inStock: inStock));
  }

  void updateImagePaths(List<String> imagePaths) {
    emit(state.copyWith(imageUrls: imagePaths));
  }

  void deleteImagePath(String imagePath) {
    emit(state.copyWith(imageUrls: List.from(state.imageUrls)..remove(imagePath)));
  }

  void updateTypes() {
    GetIt.I.get<AppDatabase>().typeDao.findAllTypes().then((value) {
      emit(state.copyWith(types: value));
    });
  }

  void updateCategories() {
    GetIt.I.get<AppDatabase>().categoryDao.findAllCategories().then((value) {
      emit(state.copyWith(categories: value));
    });
  }

  void updateSeries() {
    GetIt.I.get<AppDatabase>().seriesDao.findAllSeries().then((value) {
      emit(state.copyWith(series: value));
    });
  }

  void updateCountries() {
    GetIt.I.get<AppDatabase>().countryDao.findAllCountries().then((value) {
      emit(state.copyWith(countries: value));
    });
  }

  Future<void> addType(String name) async {
    // Add new type to repository
    final newType = await _addType(name);
    if (newType == null) {
      return;
    }
    emit(state.copyWith(
      types: List.from(state.types)..add(newType),
      selectedTypeId: newType.id!,
    ));
  }

  Future<void> addCategory(String name) async {
    // Add new category to repository
    final newCategory = await _addCategory(name);
    if (newCategory == null) {
      return;
    }
    emit(state.copyWith(
      categories: List.from(state.categories)..add(newCategory),
      selectedCategoryId: newCategory.id!,
    ));
  }

  Future<void> addSeries(String name) async {
    // Add new series to repository
    final newSeries = await _addSeries(name);
    if (newSeries == null) {
      return;
    }
    emit(state.copyWith(
      series: List.from(state.series)..add(newSeries),
      selectedSeriesId: newSeries.id!,
    ));
  }

  Future<void> addCountry(String name) async {
    // Add new country to repository
    final newCountry = await _addCountry(name);
    if (newCountry == null) {
      return;
    }
    emit(state.copyWith(
      countries: List.from(state.countries)..add(newCountry),
      selectedCountryId: newCountry.id!,
    ));
  }

  Future<TypeEntity?> _addType(String name) async {
    final typeDao = GetIt.I.get<AppDatabase>().typeDao;
    await typeDao.insertItem(TypeEntity(null, name));
    return await typeDao.findByName(name);
  }

  Future<CategoryEntity?> _addCategory(String name) async {
    final categoryDao = GetIt.I.get<AppDatabase>().categoryDao;
    await categoryDao.insertItem(CategoryEntity(null, name));
    return await categoryDao.findByName(name);
  }

  Future<SeriesEntity?> _addSeries(String name) async {
    final seriesDao = GetIt.I.get<AppDatabase>().seriesDao;
    await seriesDao.insertItem(SeriesEntity(null, name));
    return await seriesDao.findByName(name);
  }

  Future<CountryEntity?> _addCountry(String name) async {
    final countryDao = GetIt.I.get<AppDatabase>().countryDao;
    await countryDao.insertItem(CountryEntity(null, name));
    return await countryDao.findByName(name);
  }

  PostEntity? submitForm(BuildContext context) {
    if (state.title.isNotEmpty &&
        state.description.isNotEmpty &&
        state.year != null &&
        state.selectedTypeId != null &&
        state.selectedCategoryId != null &&
        state.selectedSeriesId != null &&
        state.selectedCountryId != null) {

      List<String> images = List.from(state.imageUrls);
      if (images.isEmpty) {
        images.add('404');
      }

      final post = PostEntity(
        id: this.post?.id, // Use the existing post ID if updating
        title: state.title,
        description: state.description,
        inStock: state.inStock,
        year: state.year!,
        typeId: state.selectedTypeId!,
        categoryId: state.selectedCategoryId!,
        seriesId: state.selectedSeriesId!,
        countryId: state.selectedCountryId!,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        images: json.encode(images).toString(),
      );

      if (post.id != null) {
        // Update existing post
        GetIt.I.get<AppDatabase>().postDao.updatePost(post).then((value) {
          debugPrint('Post updated');
          QR.toName(AppRoutes.homePage);
          context.read<TeaserPostsCubit>().loadTeaserPosts(null);
        });
      } else {
        // Insert new post
        GetIt.I.get<AppDatabase>().postDao.insertPost(post).then((value) {
          debugPrint('Post inserted');
          QR.toName(AppRoutes.homePage);
          context.read<TeaserPostsCubit>().loadTeaserPosts(null);
        });
      }
      return post;
    } else {
      debugPrint('Form is not complete');
    }
    return null;
  }
}
