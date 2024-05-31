import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';
import '../../../domain/entities/post_entity.dart';
import '../../routes.dart';
import 'create_post_state.dart';  // Переконайтеся, що цей пакет імпортовано правильно

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

  void submitForm() {
    if (state.title.isNotEmpty && state.description.isNotEmpty && state.year != null && state.selectedTypeId != null && state.selectedCategoryId != null && state.selectedSeriesId != null && state.selectedCountryId != null) {
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
        images: json.encode(state.imageUrls).toString(),
      );

      GetIt.I.get<AppDatabase>().postDao.insertPost(post).then((value) {
        debugPrint('Post inserted');
        QR.toName(AppRoutes.homePage);
      });
    } else {
      debugPrint('Form is not complete');
    }
  }
}
