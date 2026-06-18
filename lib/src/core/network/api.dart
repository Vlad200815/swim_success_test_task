import 'package:dio/dio.dart';
import 'package:swim_success_test_task/app/config.dart';

class Api {
  const Api();

  ///
  /// Config
  ///

  static const urlPace = "/posts";
  static const urlUsers = "/users";

  //
  // General
  //

  static const baseTimeOut = Duration(seconds: 10);
  static const contentTypeJson = "application/json";

  // Create a new instance everytime it is in use
  // As BaseOption is mutable
  static get baseDioOptions => BaseOptions(
    baseUrl: Config.baseUrl,
    contentType: contentTypeJson,
    connectTimeout: baseTimeOut,
    receiveTimeout: baseTimeOut,
    sendTimeout: baseTimeOut,
  );
}
