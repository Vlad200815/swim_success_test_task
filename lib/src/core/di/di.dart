import 'package:get_it/get_it.dart';
import 'package:swim_success_test_task/src/core/network/dio_builder.dart';

final di = GetIt.instance;

class Di {
  static void setup() async {
    /// Register Dio Builder
    di.registerLazySingleton<DioBuilder>(() => DioBuilder.getInstance());

    // AuthLocator().inject();
    // MenuLocator().inject();
    // InfoLocator().inject();
    // ProfileLocator().inject();
  }
}
