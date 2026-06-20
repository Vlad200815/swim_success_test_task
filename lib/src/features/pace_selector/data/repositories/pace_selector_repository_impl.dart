import 'package:dio/dio.dart';
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
      throw _mapDioException(e);
    } catch (e) {
      throw const UnknownFailure();
    }
  }

  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        return ServerFailure(e.response?.statusCode);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const UnknownFailure();
    }
  }
}
