import 'dart:convert';

import 'package:Collectioneer/domain/entities/series_entity.dart';
import 'package:Collectioneer/presentation/pages/home/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/entities/type_entity.dart';
import '../../routes.dart';
import 'create_post_state.dart';

class CreatePostFormCubit extends Cubit<CreatePostFormState> {

  CreatePostFormCubit() : super(CreatePostFormState.initial());

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateInStock(bool inStock) {
    emit(state.copyWith(inStock: inStock));
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

  void updateImagePaths(List<String> imageUrls) {
    emit(state.copyWith(imageUrls: imageUrls));
  }

  void deleteImagePath(String imageUrl) {
    final updatedUrls = List<String>.from(state.imageUrls)..remove(imageUrl);
    emit(state.copyWith(imageUrls: updatedUrls));
  }

  void updateTypes() {
    GetIt.I.get<AppDatabase>().typeDao.findAllTypes().then((value) {
      emit(state.copyWith(types: value));
    });
  }

  Future<void> addType(String name) async {
    final type = TypeEntity(null, name); // Replace with your actual TypeEntity constructor
    await GetIt.I.get<AppDatabase>().typeDao.insertItem(type);
    updateTypes(); // Update the list of types after insertion
  }

  void updateCategories() {
    GetIt.I.get<AppDatabase>().categoryDao.findAllCategories().then((value) {
      emit(state.copyWith(categories: value));
    });
  }

  Future<void> addCategory(String name) async {
    final category = CategoryEntity(null, name); // Replace with your actual CategoryEntity constructor
    await GetIt.I.get<AppDatabase>().categoryDao.insertItem(category);
    updateCategories(); // Update the list of categories after insertion
  }

  void updateSeries() {
    GetIt.I.get<AppDatabase>().seriesDao.findAllSeries().then((value) {
      emit(state.copyWith(series: value));
    });
  }

  Future<void> addSeries(String name) async {
    final series = SeriesEntity(null, name);
    await GetIt.I.get<AppDatabase>().seriesDao.insertItem(series);
    updateSeries();
  }

  void updateCountries() {
    GetIt.I.get<AppDatabase>().countryDao.findAllCountries().then((value) {
      emit(state.copyWith(countries: value));
    });
  }

  void addCountry(String name)  {
    final country = CountryEntity(null, name);
    GetIt.I.get<AppDatabase>().countryDao.insertItem(country).then((value) => updateCountries());
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

      GetIt.I.get<AppDatabase>().postDao.insertPost(post).then((value) {
        debugPrint('Post inserted');
        QR.toName(AppRoutes.homePage);
        context.read<TeaserPostsCubit>().loadTeaserPosts(null);
      });
      return post;
    } else {
      debugPrint('Form is not complete');
    }
    return null;
  }
}
