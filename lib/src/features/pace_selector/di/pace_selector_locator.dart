import 'package:swim_success_test_task/src/core/di/di.dart';
import 'package:swim_success_test_task/src/core/network/dio_builder.dart';
import 'package:swim_success_test_task/src/features/pace_selector/data/data_sources/remote/pace_selector_api_service.dart';
import 'package:swim_success_test_task/src/features/pace_selector/data/repositories/pace_selector_repository_impl.dart';
import 'package:swim_success_test_task/src/features/pace_selector/domain/repositories/pace_selector_repository.dart';
import 'package:swim_success_test_task/src/features/pace_selector/domain/usecases/post_pace_seconds_usecase.dart';

class PaceSelectorLocator {
  void inject() {
    /// Pace Selector Api Service
    di.registerLazySingleton<PaceSelectorApiService>(
      () => PaceSelectorApiService(di.get<DioBuilder>()),
    );

    di.registerLazySingleton<PaceSelectorRepository>(
      () => PaceSelectorRepositoryImpl(paceSelectorApiService: di.get()),
    );

    /// Post Seconds
    di.registerLazySingleton<PostPaceSecondsUseCase>(
      () => PostPaceSecondsUseCase(paceSelectorRepository: di.get()),
    );
  }
}
