import 'package:swim_success_test_task/src/core/other/usecase.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/entities.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/repositories/user_list_repository.dart';

class FetchAllUsersUseCase extends Functions<List<UserEntity>> {
  final UserListRepository _userListRepository;

  FetchAllUsersUseCase({required this._userListRepository});

  @override
  Future<List<UserEntity>> perform() async {
    return await _userListRepository.fetchUsers();
  }
}
