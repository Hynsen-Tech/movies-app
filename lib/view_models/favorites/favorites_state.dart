part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitialState extends FavoritesState {}

class FavoritesIsLoadingState extends FavoritesState{}

class FavoritesLoadedState extends FavoritesState{
  final List<MovieModel> favorites;

  const FavoritesLoadedState({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoritesErrorState extends FavoritesState {
  final String error;

  const FavoritesErrorState({required this.error});

  @override
  List<Object> get props => [error];
}