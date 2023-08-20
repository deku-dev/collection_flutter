import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/database/database.dart';
import 'create_post_state.dart';

class CreatePostFormCubit extends Cubit<CreatePostFormState> {
  CreatePostFormCubit() : super(CreatePostFormState());

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateInStock(String inStock) {
    emit(state.copyWith(inStock: inStock));
  }

  void updateYear(String year) {
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

  void updateTypes() {
    GetIt.I.get<AppDatabase>().typeDao.findAllTypes().then((value) => {
      emit(state.copyWith(types: value))
    });
  }

  void updateCategories() {
    GetIt.I.get<AppDatabase>().categoryDao.findAllCategories().then((value) => {
      emit(state.copyWith(categories: value))
    });
  }

  void updateSeries() {
    GetIt.I.get<AppDatabase>().seriesDao.findAllSeries().then((value) => {
      emit(state.copyWith(series: value))
    });
  }

  void submitForm() {}

// Add methods to update other form fields
}