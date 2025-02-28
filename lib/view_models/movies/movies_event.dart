part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchMoviesEvent extends MoviesEvent {}

final class FetchMoreMoviesEvent extends MoviesEvent {}