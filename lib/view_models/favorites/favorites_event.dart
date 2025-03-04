part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class AddToFavoritesEvent extends FavoritesEvent {
  final MovieModel movie;

  const AddToFavoritesEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

class RemoveFromFavoritesEvent extends FavoritesEvent {
  final MovieModel movie;

  const RemoveFromFavoritesEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

class RemoveAllFavoritesEvent extends FavoritesEvent {}