import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_state_management/theme/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc() : super(ThemeInitial(themeData: _getDefaultTheme())) {
    _loadTheme();
  }

  final String _isLightThemeKey = "isLightTheme";

  static ThemeData _getDefaultTheme() {
    return MyThemeData.lightTheme;
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLightTheme = prefs.getBool(_isLightThemeKey) ?? true;
    if (isLightTheme) {
      emit(LightThemeState(themeData: MyThemeData.lightTheme));
    } else {
      emit(DarkThemeState(themeData: MyThemeData.darkTheme));
    }
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = state;
    if (currentState is LightThemeState) {
      emit(DarkThemeState(themeData: MyThemeData.darkTheme));
      await prefs.setBool(_isLightThemeKey, false);
    } else {
      emit(LightThemeState(themeData: MyThemeData.lightTheme));
      await prefs.setBool(_isLightThemeKey, true);
    }
  }

}