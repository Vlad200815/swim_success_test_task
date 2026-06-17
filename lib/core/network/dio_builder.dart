import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:swim_success_test_task/app/config.dart';
import 'package:swim_success_test_task/core/network/api.dart';

class DioBuilder extends DioMixin implements Dio {
  final String contentType = Api.contentTypeJson;

  static DioBuilder getInstance() => DioBuilder._();

  DioBuilder._() {
    options = BaseOptions(
      baseUrl: Config.baseUrl,
      contentType: contentType,
      connectTimeout: Api.baseTimeOut,
      receiveTimeout: Api.baseTimeOut,
      sendTimeout: Api.baseTimeOut,
    );

    // Add custom interceptors
    interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    ]);

    httpClientAdapter = IOHttpClientAdapter();
  }
}
