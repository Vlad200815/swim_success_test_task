import 'package:swim_success_test_task/src/core/di/di.dart';
import 'package:swim_success_test_task/src/core/network/dio_builder.dart';
import 'package:swim_success_test_task/src/features/user_list/data/datasources/remote/user_list_api_service.dart';
import 'package:swim_success_test_task/src/features/user_list/data/repositories/user_list_repository_impl.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/repositories/user_list_repository.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/usecases/fetch_all_users_usecase.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/usecases/fetch_user_by_id_usecase.dart';

class UserListLocator {
  void inject() {
    /// Pace Selector Api Service
    di.registerLazySingleton<UserListApiService>(
      () => UserListApiService(di.get<DioBuilder>()),
    );

    di.registerLazySingleton<UserListRepository>(
      () => UserListRepositoryImpl(userListApiService: di.get()),
    );

    /// Get All Users
    di.registerLazySingleton<FetchAllUsersUseCase>(
      () => FetchAllUsersUseCase(userListRepository: di.get()),
    );

    /// Get User By Id
    di.registerLazySingleton<FetchUserByIdUseCase>(
          () => FetchUserByIdUseCase(userListRepository: di.get()),
    );
  }
}
