import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkUtil {

  Map<String, dynamic> handleResponse(
      {int? statusCode, dynamic response, String? errorMessage}) {
    return {
      'statusCode': statusCode,
      'response': response,
      'errorMessage': errorMessage,
    };
  }

  //GET FUNCTION
  Future<dynamic> get(String url, Map<String, String> headers) async {
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return handleResponse(statusCode: 200, response: data);
      } else {
        final errorCode = response.statusCode;
        return handleResponse(statusCode: errorCode, errorMessage: "Error: $errorCode");
      }
    } on TimeoutException catch (_) {
      return handleResponse(statusCode: 504, errorMessage: 'Timeout');
    } on Error catch (_) {
      return handleResponse(statusCode: 000, errorMessage: 'Error catched');
    } on Exception catch (_) {
      return handleResponse(statusCode: 000, errorMessage: 'Exception catched');
    }
  } //GET FUNCTION

}
