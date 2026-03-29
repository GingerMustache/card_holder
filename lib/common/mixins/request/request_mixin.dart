import 'package:card_holder/common/exceptions/server_exceptions.dart';
import 'package:card_holder/common/helpers/json_parser.dart';
import 'package:dio/dio.dart';

mixin RequestMixin {
  Dio get dioClient;

  Future<Response> _post(String path, Object data, Options? options) async {
    final Response response = await dioClient.post(
      path,
      data: data,
      options: options,
    );

    if (!(response.statusCode == 200 || response.statusCode == 201)) {
      throw ServerException(response.data['message']);
    }

    return response;
  }

  Future<Response> _get(
    String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  ) async {
    final Response response = await dioClient.get(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    if (!(response.statusCode == 200 || response.statusCode == 201)) {
      throw ServerException();
    }

    return response;
  }

  Future<T> postSingle<T>({
    required String path,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    String? dataKey,
    Options? options,
  }) async {
    final Response response = await _post(path, data, options);

    if (dataKey != null && response.data[dataKey] != null) {
      return fromJson(response.data[dataKey]);
    }

    return fromJson(response.data);
  }

  Future<bool> postBoolean({
    required String path,
    required dynamic data,
    Options? options,
  }) async {
    await _post(path, data, options);
    return true;
  }

  Future<List<T>> postList<T>({
    required String path,
    required dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
    String? dataKey,
    Options? options,
  }) async {
    final Response response = await _post(path, data, options);

    if (dataKey != null && response.data[dataKey] != null) {
      try {
        final result = JsonParser.list(response.data[dataKey], fromJson);

        return result;
      } catch (e) {
        print(e.toString());
      }
    }

    return JsonParser.list(response.data, fromJson);
  }

  Future<T> getSingle<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
    String? dataKey,
  }) async {
    final Response response = await _get(path, data, queryParameters);

    if (dataKey != null && response.data[dataKey] != null) {
      return fromJson(response.data[dataKey]);
    }

    return fromJson(response.data);
  }
}
