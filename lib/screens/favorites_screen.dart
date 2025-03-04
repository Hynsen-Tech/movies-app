import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/theme/icons.dart';
import 'package:mvvm_state_management/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_state_management/widgets/error_widget.dart';
import 'package:mvvm_state_management/widgets/loading_widget.dart';
import '../services/init_getit.dart';
import '../widgets/movies/movies_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesBloc favoritesBloc = getIt<FavoritesBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Movies'),
        actions: [
          IconButton(
            onPressed: () {
              favoritesBloc.add(RemoveAllFavoritesEvent());
            },
            icon: const Icon(MyAppIcons.delete),
            color: Colors.red,
          ),
        ],
      ),
      body:
          BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
        switch (state) {
          case FavoritesIsLoadingState():
            return LoadingWidget();
          case FavoritesLoadedState():
            List<MovieModel> favorites = state.favorites;
            if (favorites.isEmpty) {
              return const Center(
                child: Text(
                  "The favorites list is empty!",
                  style: TextStyle(fontSize: 16),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return MoviesWidget(
                      movie: favorites[index],
                    );
                  });
            }
          default:
            String errorMessage = "Some error occurred";
            if (state is FavoritesErrorState) {
              errorMessage = state.error;
            }
            return MyErrorWidget(
                errorText: errorMessage,
                retryFunction: () {
                  favoritesBloc.add(LoadFavoritesEvent());
                });
        }
      }),
    );
  }
}
