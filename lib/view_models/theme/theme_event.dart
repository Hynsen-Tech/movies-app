part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class LoadThemeEvent extends ThemeEvent {}

final class ToggleThemeEvent extends ThemeEvent {}