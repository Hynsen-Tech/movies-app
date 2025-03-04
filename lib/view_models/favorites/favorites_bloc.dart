import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/movie_model.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitialState()) {
    on<LoadFavoritesEvent>(_loadFavorites);
    on<AddToFavoritesEvent>(_addToFavorites);
    on<RemoveFromFavoritesEvent>(_removeFromFavorites);
    on<RemoveAllFavoritesEvent>(_clearAllFavorites);
  }

  final favoritesKey = "favoritesKey";

  Future<void> _saveFavoritesList(List<MovieModel> favoritesList) async {
    final favPrefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = favoritesList
        .map((favorite) => json.encode(favorite.toJson()))
        .toList();
    await favPrefs.setStringList(favoritesKey, favoritesJson);
  }

  bool isFavorite(MovieModel movie) {
    if (state is FavoritesLoadedState) {
      return (state as FavoritesLoadedState)
          .favorites
          .any((element) => element.id == movie.id);
    } else {
      return false;
    }
  }

  Future<void> _loadFavorites(event, emit) async {
    final favPrefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson =
        favPrefs.getStringList(favoritesKey) ?? [];
    final List<MovieModel> favorites = favoritesJson
        .map((element) => MovieModel.fromJson(json.decode(element)))
        .toList();
    emit(FavoritesLoadedState(favorites: favorites));
  }

  Future<void> _addToFavorites(AddToFavoritesEvent event, emit) async {
    if (state is FavoritesLoadedState) {
      if (!isFavorite(event.movie)) {
        final List<MovieModel> favoritesList =
        List.from((state as FavoritesLoadedState).favorites)
          ..add(event.movie);
        await _saveFavoritesList(favoritesList);
        emit(FavoritesLoadedState(favorites: favoritesList));}
    }
  }

  Future<void> _removeFromFavorites(
      RemoveFromFavoritesEvent event, emit) async {
    if (state is FavoritesLoadedState) {
      final List<MovieModel> favoritesList =
          List.from((state as FavoritesLoadedState).favorites)
            ..removeWhere((element) => element.id == event.movie.id);
      await _saveFavoritesList(favoritesList);
      emit(FavoritesLoadedState(favorites: favoritesList));
    }
  }

  Future<void> _clearAllFavorites(event, emit) async {
    await _saveFavoritesList([]);
    emit(FavoritesLoadedState(favorites: []));
  }
}
