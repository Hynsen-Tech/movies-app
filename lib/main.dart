import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_state_management/screens/movies_screen.dart';
import 'package:mvvm_state_management/screens/splash_screen.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/theme/theme_data.dart';
import 'package:mvvm_state_management/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_state_management/view_models/movies/movies_bloc.dart';
import 'package:mvvm_state_management/view_models/theme/theme_bloc.dart';
import 'services/navigation_service.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>(),
        ),
        BlocProvider<MoviesBloc>(
            create: (_) => getIt<MoviesBloc>()..add(FetchMoviesEvent())),
        BlocProvider<FavoritesBloc>(
            create: (_) => getIt<FavoritesBloc>()..add(LoadFavoritesEvent())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: state is DarkThemeState
                ? MyThemeData.darkTheme
                : MyThemeData.lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
