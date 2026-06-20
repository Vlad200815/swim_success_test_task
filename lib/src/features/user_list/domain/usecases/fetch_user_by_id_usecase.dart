import 'package:swim_success_test_task/src/core/other/usecase.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/entities.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/repositories/user_list_repository.dart';

class FetchUserByIdUseCase extends Functions1<int, UserEntity> {
  final UserListRepository _userListRepository;

  FetchUserByIdUseCase({required this._userListRepository});

  @override
  Future<UserEntity> perform(int userId) async {
    return await _userListRepository.fetchUserById(userId: userId);
  }
}