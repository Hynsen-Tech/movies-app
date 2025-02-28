import 'package:flutter/material.dart';
import 'package:mvvm_state_management/models/movie_genre_model.dart';
import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/utils/genre_util.dart';
import '../chip_widget.dart';

class GenresListWidget extends StatelessWidget {
  const GenresListWidget({super.key, required this.genreIds});

  //TODO implement required
  final List<int> genreIds;

  @override
  Widget build(BuildContext context) {
    final List<MovieGenreModel> genresName = getIt<GenreUtil>().getMovieGenresName(genreIds);

    return Wrap(
      children: List.generate(
        genresName.length,
        (index) => ChipWidget(
          genreName: genresName[index].name,
        ),
      ),
    );
  }
}
