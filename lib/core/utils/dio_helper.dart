
import 'package:dio/dio.dart';

import 'constants.dart';
import 'package:http/http.dart' as http;
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

   Future<Response> getDataDio({
  required String url,
  Map<String, dynamic>? query,
}) async {
  // Add default headers
  dio.options.headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Accept': 'application/json',
  };

  // Optional: Add CORS-specific headers if required by the server
  dio.options.headers['Access-Control-Allow-Origin'] = '*'; // Adjust this based on your server config

  try {
    return await dio.get(
      url,
      queryParameters: query,
    );
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}



Future<http.Response> getData({
  required String url,
  Map<String, dynamic>? query,
}) async {
  try {
    // Construct the query parameters into a query string
    final uri = Uri.parse(baseUrl+url).replace(queryParameters: query);

    // Add default headers
    final headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
    };

    // Make the HTTP GET request
    final response = await http.get(uri, headers: headers);

    // Check for errors in the response
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception(
          'Failed to load data: ${response.statusCode} ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

   Future<Response>   postData({
    required String url,
   required  Map<String, dynamic> data,
    Map<String, dynamic>? query,
    bool isFormData = false,
  }) async {
    if (isFormData) {
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      return dio.post(
        url,
        queryParameters: query,
        data: FormData.fromMap(data),
      );
    } else {
      dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';

      return dio.post(
        url,
        queryParameters: query,
        data: data,
      );
    }
  }

   void setHeder(Map<String, dynamic> heders) {
    dio.options.headers = heders;
  }

   Future<Response> deleteData({
    required String url,
     Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
     dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
    return await dio.delete(
      "$url${query!['id']}",
      
      
    );
  }
}
