import 'package:flutter_bloc/flutter_bloc.dart';

enum SortOrder { ascending, descending }

class SortingCubit extends Cubit<SortOrder> {
  SortingCubit() : super(SortOrder.ascending);

  void toggleSortOrder() {
    emit(state == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending);
  }
}
