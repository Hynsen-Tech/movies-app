import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:mvvm_state_management/models/movie_genre_model.dart';
import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/repository/movie_repository.dart';
import 'package:mvvm_state_management/utils/genre_util.dart';

import '../../services/init_getit.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitialState()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<FetchMoreMoviesEvent>(_onFetchMoreMovies);
  }

  final MovieRepository _movieRepo = getIt<MovieRepository>();

  Future<void> _onFetchMovies(event, emit) async {
    emit(MoviesIsLoadingState());
    final Map<String, dynamic> genresResponse = await _movieRepo.fetchGenre();
    if (genresResponse['responseCode'] == 1) {
      getIt<GenreUtil>().addMovieGenres = genresResponse['response'];
      final Map<String, dynamic> moviesResponse =
          await _movieRepo.fetchMovies(page: 1);
      if (moviesResponse['responseCode'] == 1) {
        emit(
          MoviesLoadedState(
            movies: moviesResponse['response'],
            movieGenres: genresResponse['response'],
            currentPage: 1,
          ),
        );
      } else {
        emit(MoviesErrorState(errorMessage: moviesResponse['response']));
      }
    } else {
      emit(MoviesErrorState(errorMessage: genresResponse['response']));
    }
  }

  Future<void> _onFetchMoreMovies(event, emit) async {
    final MoviesState currentState = state;
    if(currentState is! MoviesLoadedState || currentState.currentPage >= 500) {
      return;
    } else {
      int currentLoadingPage = currentState.currentPage + 1;
      emit(MoviesIsLoadingMoreState(
        movies: currentState.movies,
        movieGenres: currentState.movieGenres,
        currentPage: currentLoadingPage
      ));
      final Map<String, dynamic> moviesResponse = await _movieRepo.fetchMovies(page: currentLoadingPage);
      if(moviesResponse['responseCode'] == 1) {
        final List<MovieModel> movies = moviesResponse['response'];
        currentState.movies.addAll(movies);
        emit(MoviesLoadedState(
            movies: currentState.movies,
            movieGenres: currentState.movieGenres,
            currentPage: currentLoadingPage
        ));
      } else {
        emit(MoviesErrorState(errorMessage: moviesResponse['response']));
      }
    }
  }
}
