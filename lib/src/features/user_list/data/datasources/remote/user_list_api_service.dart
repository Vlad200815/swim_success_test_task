import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:swim_success_test_task/src/core/network/api.dart';

import '../../models/models.dart';

part 'user_list_api_service.g.dart';

@RestApi()
abstract class UserListApiService {
  factory UserListApiService(Dio dioBuilder) = _UserListApiService;

  ///
  /// GET USERS
  ///

  @GET(Api.urlUsers)
  Future<List<UserDto>> fetchAllUsers();
}
