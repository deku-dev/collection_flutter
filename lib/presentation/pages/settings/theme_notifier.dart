import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define theme cubit
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false) {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode);
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = state;
    isDarkMode = !isDarkMode;
    prefs.setBool('isDarkMode', isDarkMode);
    emit(isDarkMode);
  }
}