import 'package:get_it/get_it.dart';
import 'package:mvvm_state_management/services/navigation_service.dart';
import 'package:mvvm_state_management/utils/network_util.dart';
import 'package:mvvm_state_management/view_models/movies/movies_bloc.dart';
import 'package:mvvm_state_management/view_models/theme/theme_bloc.dart';
import '../repository/movie_repository.dart';
import '../utils/genre_util.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(()=>NavigationService());
  getIt.registerLazySingleton<NetworkUtil>(()=>NetworkUtil());
  getIt.registerLazySingleton<MovieRepository>(()=>MovieRepository());
  getIt.registerLazySingleton<GenreUtil>(()=>GenreUtil());
  getIt.registerLazySingleton<ThemeBloc>(()=>ThemeBloc());
  getIt.registerLazySingleton<MoviesBloc>(()=>MoviesBloc());
}