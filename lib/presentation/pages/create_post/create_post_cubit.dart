import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/domain/entities/post_entity.dart';
import 'package:flutter_app/presentation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';
import 'create_post_state.dart';

class CreatePostFormCubit extends Cubit<CreatePostFormState> {
  CreatePostFormCubit() : super(CreatePostFormState());

  final ImagePicker _picker = ImagePicker();

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

  Future<void> pickAndSaveImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File tempImage = File(pickedFile.path);
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String appPath = appDir.path;
      final String fileName = basename(tempImage.path);
      final String savedImagePath = '$appPath/Collection/$fileName';

      final File localImage = await tempImage.copy(savedImagePath);
      List<String> updatedImageUrls = List.from(state.imageUrls)..add(localImage.path);

      emit(state.copyWith(imageUrls: updatedImageUrls));
    }
  }

  void updateImagePaths(List<String> imagePaths) {
    emit(state.copyWith(imageUrls: imagePaths));
  }

  void deleteImagePath(String path) {
    final List<String> updatedImagePaths = List.from(state.imageUrls)..remove(path);
    emit(state.copyWith(imageUrls: updatedImagePaths));
  }

  void submitForm() {
    final post = PostEntity(
      title: state.title,
      description: state.description,
      inStock: state.inStock,
      year: state.year,
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
  }

// Add methods to update other form fields
}
