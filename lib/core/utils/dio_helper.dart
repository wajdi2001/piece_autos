
import 'package:dio/dio.dart';

import 'constants.dart';

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

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {

          dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response>   postData({
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

  static void setHeder(Map<String, dynamic> heders) {
    dio.options.headers = heders;
  }

  static Future<Response> deleteData({
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
