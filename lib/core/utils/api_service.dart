import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(
    headers: {},
    validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 422) {
        return true;
      } else {
        return statusCode >= 200 && statusCode < 300;
      }
    },
  ));

  Future<Map<String, dynamic>?> post(
      {required String url, required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(url, data: data);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> get({required String url, String? token}) async {
    try {
      final response = await dio.get(url,
          options: Options(
              headers: token == null ? null : {'Authorization': token}));
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> delete({required String url}) async {
    final response = await dio.delete(url);
    print(response.data);
  }

  Future<dynamic> patch(
      {required String url, required Map<String, dynamic> data}) async {
    try {
      final response = await dio.patch(url, data: data);
      print(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
