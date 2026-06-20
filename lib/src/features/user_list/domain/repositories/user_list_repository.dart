import '../entities/user_entity.dart';

abstract interface class UserListRepository {
  Future<List<UserEntity>> fetchUsers();

  Future<UserEntity> fetchUserById({required int userId});
}
