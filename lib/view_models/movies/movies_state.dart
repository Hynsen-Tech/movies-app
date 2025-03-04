part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

final class MoviesInitialState extends MoviesState {}

final class MoviesIsLoadingState extends MoviesState {}

final class MoviesLoadedState extends MoviesState {
  final List<MovieModel> movies;
  final List<MovieGenreModel> movieGenres;
  final int currentPage;

  const MoviesLoadedState({
    this.movies = const [],
    this.movieGenres = const [],
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [movies, movieGenres, currentPage];
}

final class MoviesIsLoadingMoreState extends MoviesState {
  final List<MovieModel> movies;
  final List<MovieGenreModel> movieGenres;
  final int currentPage;

  const MoviesIsLoadingMoreState({
    this.movies = const [],
    this.movieGenres = const [],
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [movies, movieGenres, currentPage];
}

final class MoviesErrorState extends MoviesState {
  final String errorMessage;

  const MoviesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
