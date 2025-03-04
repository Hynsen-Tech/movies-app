import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/screens/favorites_screen.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/services/navigation_service.dart';
import 'package:mvvm_state_management/theme/icons.dart';
import 'package:mvvm_state_management/view_models/movies/movies_bloc.dart';
import 'package:mvvm_state_management/view_models/theme/theme_bloc.dart';
import 'package:mvvm_state_management/widgets/loading_widget.dart';
import '../repository/movie_repository.dart';
import '../widgets/error_widget.dart';
import '../widgets/movies/movies_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            onPressed: () {
              getIt<NavigationService>()
                  .navigate(FavoritesScreen(/*movies: _movies*/));
            },
            icon: const Icon(MyAppIcons.favoriteRounded),
            color: Colors.red,
          ),
          IconButton(
            onPressed: () {
              //context.read<ThemeBloc>().add(ToggleThemeEvent());
              getIt<ThemeBloc>().add(ToggleThemeEvent());
            },
            icon: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
              return Icon(
                state is DarkThemeState
                    ? MyAppIcons.lightMode
                    : MyAppIcons.darkMode,
              );
            }),
          )
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        final moviesBloc = getIt<MoviesBloc>();
        final currentState = state;
        switch (currentState) {
          case MoviesIsLoadingState():
            return LoadingWidget();
          case MoviesLoadedState() || MoviesIsLoadingMoreState():
            final List<MovieModel> movies = currentState is MoviesLoadedState
                ? currentState.movies
                : (currentState as MoviesIsLoadingMoreState).movies;
            if (movies.isEmpty) {
              return MyErrorWidget(
                errorText: 'No movies founded',
                retryFunction: () {
                  moviesBloc.add(FetchMoviesEvent());
                },
              );
            } else {
              final int moviesLength = currentState is MoviesLoadedState
                  ? movies.length
                  : movies.length + 1;
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      currentState is MoviesLoadedState) {
                    moviesBloc.add(FetchMoreMoviesEvent());
                    return true;
                  } else {
                    return false;
                  }
                },
                child: ListView.builder(
                    itemCount: moviesLength,
                    itemBuilder: (context, index) {
                      if (index >= movies.length) {
                        return SizedBox(
                          height: 40,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return MoviesWidget(
                          movie: movies[index],
                        );
                      }
                    }),
              );
            }
          default:
            if (currentState is MoviesErrorState) {
              return MyErrorWidget(
                errorText: currentState.errorMessage,
                retryFunction: () {
                  moviesBloc.add(FetchMoviesEvent());
                },
              );
            } else {
              return MyErrorWidget(
                errorText: 'Some error occurred',
                retryFunction: () {
                  moviesBloc.add(FetchMoviesEvent());
                },
              );
            }
        }
      }),
    );
  }
}
