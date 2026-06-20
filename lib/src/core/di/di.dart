import 'package:get_it/get_it.dart';
import 'package:swim_success_test_task/src/core/network/dio_builder.dart';
import 'package:swim_success_test_task/src/features/pace_selector/di/pace_selector_locator.dart';

final di = GetIt.instance;

class Di {
  static void setup() async {
    /// Register Dio Builder
    di.registerLazySingleton<DioBuilder>(() => DioBuilder.getInstance());

    PaceSelectorLocator().inject();
  }
}
