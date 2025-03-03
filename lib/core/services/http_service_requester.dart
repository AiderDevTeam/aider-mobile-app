import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../errors/errors.dart';
import '../services/api_config.dart';
import '../services/logger_service.dart';
import '../services/network_connection_service.dart';
import '../utils/helper_util.dart';

class HttpServiceRequester {
  static final HttpServiceRequester _httpServiceRequester =
      HttpServiceRequester._internal();
  factory HttpServiceRequester() => _httpServiceRequester;
  HttpServiceRequester._internal();

  final dio = Dio();
  bool isProduction =
      RemoteConfigService.getRemoteData.configs['env']['production'] == 'true';

  Future<Response> postRequest({
    required String endpoint,
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParam,
    String? token,
  }) async {
    if (await NetworkConnectionService.isConnected) {
      final headers = await ApiConfig.getHttpHeaders();
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      final cancelToken = CancelToken();
      dio.options.headers = headers;
      dio.options.followRedirects = false;
      final response = await dio
          .post<dynamic>(
            endpoint,
            data: json.encode(requestBody),
            queryParameters: queryParam,
            options: Options(
              headers: headers,
            ),
            cancelToken: cancelToken,
          )
          .timeout(Duration(seconds: HelperUtil.timeOutSeconds));

      if (!isProduction) {
        ZLoggerService.logRequests(
            endpoint: endpoint,
            method: 'POST',
            realUri: response.realUri.toString(),
            body: requestBody,
            queryParam: queryParam,
            statusCode: response.statusCode.toString(),
            response: response.data);
      }

      return response;
    } else {
      throw NoInternetException();
    }
  }

  Future<Response> putRequest({
    required String endpoint,
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParam,
  }) async {
    if (await NetworkConnectionService.isConnected) {
      final headers = await ApiConfig.getHttpHeaders();
      final cancelToken = CancelToken();

      dio.options.headers = headers;
      dio.options.followRedirects = false;
      final response = await dio
          .put<dynamic>(
            endpoint,
            data: json.encode(requestBody),
            queryParameters: queryParam,
            options: Options(
              headers: headers,
            ),
            cancelToken: cancelToken,
          )
          .timeout(Duration(seconds: HelperUtil.timeOutSeconds));

      if (!isProduction) {
        ZLoggerService.logRequests(
          endpoint: endpoint,
          method: 'PUT',
          realUri: response.realUri.toString(),
          body: requestBody,
          queryParam: queryParam,
          statusCode: response.statusCode.toString(),
          response: response.data,
        );
      }

      return response;
    } else {
      throw NoInternetException();
    }
  }

  Future<Response> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParam,
  }) async {
    if (await NetworkConnectionService.isConnected) {
      final headers = await ApiConfig.getHttpHeaders();
      final response = await retry(
        () => dio
            .get<dynamic>(
              endpoint,
              options: Options(
                headers: headers,
              ),
              queryParameters: queryParam,
            )
            .timeout(Duration(seconds: HelperUtil.timeOutSeconds)),
        retryIf: (e) =>
            e is SocketException ||
            e is TimeoutException ||
            (e is DioException &&
                (e.type == DioExceptionType.connectionTimeout ||
                    e.type == DioExceptionType.sendTimeout ||
                    e.type == DioExceptionType.receiveTimeout)),
      );

      if (!isProduction) {
        ZLoggerService.logRequests(
            endpoint: endpoint,
            method: 'GET',
            realUri: response.realUri.toString(),
            queryParam: queryParam,
            statusCode: response.statusCode.toString(),
            response: response.data);
      }

      return response;
    } else {
      throw NoInternetException();
    }
  }

  Future<Response> deleteRequest({
    required String endpoint,
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParam,
  }) async {
    if (await NetworkConnectionService.isConnected) {
      final headers = await ApiConfig.getHttpHeaders();

      dio.options.headers = headers;
      final response = await dio
          .delete<dynamic>(
            endpoint,
            data: json.encode(requestBody),
            queryParameters: queryParam,
            options: Options(
              headers: headers,
            ),
          )
          .timeout(Duration(seconds: HelperUtil.timeOutSeconds));

      if (!isProduction) {
        ZLoggerService.logRequests(
          endpoint: endpoint,
          method: 'DELETE',
          realUri: response.realUri.toString(),
          queryParam: queryParam,
          body: requestBody,
          statusCode: response.statusCode.toString(),
        );
      }

      return response;
    } else {
      throw NoInternetException();
    }
  }

  Future<Response> postFormDataRequest({
    required String endpoint,
    FormData? requestBody,
    Map<String, dynamic>? queryParam,
  }) async {
    if (await NetworkConnectionService.isConnected) {
      final headers = await ApiConfig.getHttpHeaders();
      final cancelToken = CancelToken();
      dio.options.headers = headers;
      dio.options.followRedirects = false;
      final response = await dio
          .post<dynamic>(
            endpoint,
            data: requestBody,
            queryParameters: queryParam,
            options: Options(
              headers: headers,
            ),
            cancelToken: cancelToken,
          )
          .timeout(Duration(seconds: HelperUtil.timeOutSeconds));

      if (!isProduction) {
        ZLoggerService.logRequests(
            endpoint: endpoint,
            method: 'POST',
            realUri: response.realUri.toString(),
            body: {},
            queryParam: queryParam,
            statusCode: response.statusCode.toString(),
            response: response.data);
      }

      return response;
    } else {
      throw NoInternetException();
    }
  }
}
