import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
      return await dio!.get(url, queryParameters: query);
  }
}
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=875b753f78a944d18c20e7f5a3ac37fa