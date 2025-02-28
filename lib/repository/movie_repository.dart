import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/utils/network_util.dart';
import '../constants/api_constants.dart';
import '../models/movie_genre_model.dart';

class MovieRepository {

  Future<dynamic> fetchMovies({int page = 1}) async {
    final String url = '${ApiConstants.baseUrl}/movie/popular?language=en-US&page=$page';
    final Map<String, String> headers = ApiConstants.headers;
    final response = await getIt<NetworkUtil>().get(url, headers);
    return handleResponse(response: response, value: 'results', createResponse: (value) {
      List<MovieModel> moviesList = List.from(value.map((element)=>MovieModel.fromJson(element)));
      return moviesList;
    });
  }

  Future<dynamic> fetchGenre() async {
    final String url = '${ApiConstants.baseUrl}/genre/movie/list?language=en';
    final Map<String, String> headers = ApiConstants.headers;
    final response = await getIt<NetworkUtil>().get(url, headers);
    return handleResponse(response: response, value: 'genres', createResponse: (value) {
      List<MovieGenreModel> movieGenresList = List.from(value.map((element)=>MovieGenreModel.fromJson(element)));
      return movieGenresList;
    });
  }

  Map<String, dynamic> handleResponse({required Map<String, dynamic> response,required String value ,required Function createResponse}) {
    if( response['statusCode'] == 200) {
      final data = response['response'];
      final responseData = createResponse(data[value]);
      return {
        'responseCode': 1,
        'response': responseData
      };
    } else {
      return {
        'responseCode': 0,
        'response': response['errorMessage']
      };
    }
  }
}