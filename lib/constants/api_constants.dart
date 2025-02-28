class ApiConstants {
  static const String apiKey = 'APIKEY';
  static const String bearerToken =
      'BEARERTOKEN';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static Map<String, String> headers = {
    'Authorization': 'Bearer $bearerToken',
    'accept': 'application/json',
  };
}
