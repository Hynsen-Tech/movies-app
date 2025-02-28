import 'package:mvvm_state_management/models/movie_genre_model.dart';
import 'package:mvvm_state_management/services/init_getit.dart';

class GenreUtil {
  final List<MovieGenreModel> _movieGenres = [];

  List<MovieGenreModel> get movieGenres {
    return _movieGenres;
  }

  set addMovieGenres(List<MovieGenreModel> genresList) {
    _movieGenres.addAll(genresList);
  }

  List<MovieGenreModel> getMovieGenresName(List<int> genreIds) {
    final List<MovieGenreModel> movieGenresList = [];
    for (int genreId in genreIds) {
      movieGenresList.add(movieGenres.firstWhere((g) => g.id == genreId,
          orElse: () => MovieGenreModel(id: -1, name: 'Unknown')));
    }
    return movieGenresList;
  }
}
