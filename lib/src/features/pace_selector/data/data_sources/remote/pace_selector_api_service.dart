import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:swim_success_test_task/src/core/network/api.dart';
import 'package:swim_success_test_task/src/features/pace_selector/data/models/pace_seconds_dto.dart';

part 'pace_selector_api_service.g.dart';

@RestApi()
abstract class PaceSelectorApiService {
  factory PaceSelectorApiService(Dio dioBuilder) = _PaceSelectorApiService;

  ///
  /// PACE SECONDS
  ///
  @POST(Api.urlPace)
  Future<void> postPaceSeconds(@Body() PaceSecondsDto body);
}
