import 'package:dio/dio.dart';
import 'package:swim_success_test_task/src/core/network/dio_exception_mapper.dart';
import 'package:swim_success_test_task/src/core/network/failure.dart';
import 'package:swim_success_test_task/src/features/pace_selector/data/data_sources/remote/pace_selector_api_service.dart';
import 'package:swim_success_test_task/src/features/pace_selector/data/models/pace_seconds_dto.dart';
import 'package:swim_success_test_task/src/features/pace_selector/domain/repositories/pace_selector_repository.dart';

class PaceSelectorRepositoryImpl implements PaceSelectorRepository {
  final PaceSelectorApiService _paceSelectorApiService;

  PaceSelectorRepositoryImpl({required this._paceSelectorApiService});

  @override
  Future<void> postPaceSeconds({required int paceSeconds}) async {
    try {
      await _paceSelectorApiService.postPaceSeconds(
        PaceSecondsDto(paceSeconds: paceSeconds),
      );
    } on DioException catch (e) {
      throw DioExceptionMapper.mapDioException(e);
    } catch (e) {
      throw const UnknownFailure();
    }
  }
}
