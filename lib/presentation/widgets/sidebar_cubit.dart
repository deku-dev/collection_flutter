import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarCubit extends Cubit<int?> {
  SidebarCubit() : super(null);

  void selectCategory(int? categoryId) {
    emit(categoryId);
  }

  void clearSelection() {
    emit(null);
  }
}
