class MovieModel {
  int id;
  String title;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  MovieModel({required this.id,
    required this.title,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        title: json['title'],
        adult: json['adult'],
        backdropPath: json['backdrop_path'] ?? '',
        genreIds: List<int>.from(json['genre_ids']),
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'] ?? '',
        releaseDate: json['release_date'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'title': title,
    'adult': adult,
    'backdrop_path': backdropPath,
    'genre_ids': genreIds,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'release_date': releaseDate,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    };
  }
}
