import 'package:dio/dio.dart';

class DioService {
  DioService._();

  static Future<Dio> createBaseDio() async {
    return Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) => status! < 501,
      ),
    );
  }
}
