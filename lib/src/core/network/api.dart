import 'package:dio/dio.dart';
import 'package:swim_success_test_task/src/app/config.dart';

class Api {
  const Api();

  ///
  /// Config
  ///
  static const String id = "id";

  static const urlPace = "/posts";
  static const urlUsers = "/users";
  static const urlUserById = "/users/{$id}";

  //
  // General
  //

  static const baseTimeOut = Duration(seconds: 10);
  static const contentTypeJson = "application/json";

  // Create a new instance everytime it is in use
  // As BaseOption is mutable
  static BaseOptions get baseDioOptions => BaseOptions(
    baseUrl: Config.baseUrl,
    contentType: contentTypeJson,
    connectTimeout: baseTimeOut,
    receiveTimeout: baseTimeOut,
    sendTimeout: baseTimeOut,
  );
}
