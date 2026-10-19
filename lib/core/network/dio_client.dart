
import 'package:apache_connect/core/network/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  DioClient._();

  static final Dio instance = Dio(
    BaseOptions(
      // baseUrl: 'http://10.3.0.70:8155',
       baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint(
            'DIO REQUEST: ${options.method} ${options.uri}',
          );
          debugPrint(
            'DIO REQUEST: body keys = '
            '${(options.data as Map?)?.keys.toList()}',
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            'DIO RESPONSE: status = ${response.statusCode}',
          );

          final data = response.data;
          if (data is Map) {
            debugPrint(
              'DIO RESPONSE: success = ${data['success']}',
            );
            debugPrint(
              'DIO RESPONSE: message = ${data['message']}',
            );
          }

          handler.next(response);
        },
        onError: (error, handler) {
          debugPrint(
            'DIO ERROR: ${error.response?.statusCode}',
          );
          debugPrint(
            'DIO ERROR: ${error.response?.data}',
          );
          debugPrint('DIO ERROR: ${error.message}');

          handler.next(error);
        },
      ),
    );
}
