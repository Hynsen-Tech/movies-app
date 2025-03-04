import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_state_management/repository/movie_repository.dart';
import 'package:mvvm_state_management/screens/movies_screen.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/services/navigation_service.dart';
import 'package:mvvm_state_management/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_state_management/view_models/movies/movies_bloc.dart';
import 'package:mvvm_state_management/widgets/error_widget.dart';
import 'package:mvvm_state_management/widgets/loading_widget.dart';

import '../utils/genre_util.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = getIt<MoviesBloc>();
    final favoritesBloc = getIt<FavoritesBloc>();

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MoviesBloc, MoviesState>(
            listener: (context, state) {
              if (state is MoviesLoadedState &&
                  favoritesBloc.state is FavoritesLoadedState) {
                getIt<NavigationService>()
                    .navigateReplacing(const MoviesScreen());
              }
            },
          ),
          BlocListener<FavoritesBloc, FavoritesState>(
            listener: (context, state) {
              if (favoritesBloc.state is FavoritesLoadedState) {
                getIt<NavigationService>()
                    .navigateReplacing(const MoviesScreen());
              }
            },
          ),
        ],
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            final currentState = state;
            switch (currentState) {
              case MoviesInitialState() || MoviesIsLoadingState():
                return LoadingWidget();
              case MoviesLoadedState():
                return SizedBox.shrink();
              case MoviesErrorState():
                return MyErrorWidget(
                  errorText: currentState.errorMessage,
                  retryFunction: () {
                    moviesBloc.add(FetchMoviesEvent());
                  },
                );
              default:
                return MyErrorWidget(
                  errorText: "Error",
                  retryFunction: () {
                    moviesBloc.add(FetchMoviesEvent());
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
