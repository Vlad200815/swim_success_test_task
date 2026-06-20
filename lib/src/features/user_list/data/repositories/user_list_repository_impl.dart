import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:swim_success_test_task/src/core/network/dio_exception_mapper.dart';
import 'package:swim_success_test_task/src/core/network/failure.dart';
import 'package:swim_success_test_task/src/features/user_list/data/datasources/remote/user_list_api_service.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/user_entity.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/repositories/user_list_repository.dart';

class UserListRepositoryImpl implements UserListRepository {
  final UserListApiService _userListApiService;

  UserListRepositoryImpl({required this._userListApiService});

  @override
  Future<List<UserEntity>> fetchUsers() async {
    try {
      debugPrint("Try to call fetchAllUsers");

      final result = await _userListApiService.fetchAllUsers();
      debugPrint("Took result: $result");

      final List<UserEntity> users = result
          .map(
            (userDto) => UserEntity(
              id: userDto.id,
              name: userDto.name,
              username: userDto.username,
              email: userDto.email,
              address: userDto.address?.toEntity(),
              phone: userDto.phone,
              website: userDto.website,
              company: userDto.company?.toEntity(),
            ),
          )
          .toList();
      debugPrint("Took mapped users: $users");

      return users;
    } on DioException catch (e) {
      throw DioExceptionMapper.mapDioException(e);
    } catch (e) {
      debugPrint("Error is: $e");
      throw const UnknownFailure();
    }
  }
}
