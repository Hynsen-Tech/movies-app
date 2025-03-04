import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/view_models/favorites/favorites_bloc.dart';

import '../../theme/icons.dart';

class FavoriteBtnWidget extends StatefulWidget {
  const FavoriteBtnWidget({super.key, required this.movie, this.iconSize = 23});

  final MovieModel movie;
  final double iconSize;

  @override
  State<FavoriteBtnWidget> createState() => _FavoriteBtnWidgetState();
}

class _FavoriteBtnWidgetState extends State<FavoriteBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
      bool isFavorite = state is FavoritesLoadedState &&
          getIt<FavoritesBloc>().isFavorite(widget.movie);
      return IconButton(
        onPressed: () {
          getIt<FavoritesBloc>().add(state is FavoritesLoadedState && isFavorite
              ? RemoveFromFavoritesEvent(movie: widget.movie)
              : AddToFavoritesEvent(movie: widget.movie));
        },
        icon: state is FavoritesLoadedState && isFavorite
            ? Icon(MyAppIcons.favoriteRounded, color: Colors.red,)
            : Icon(MyAppIcons.favoriteRoundedOutline),
        //color: Colors.red,
        iconSize: widget.iconSize,
      );
    });
  }
}
