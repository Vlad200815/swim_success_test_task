import 'package:swim_success_test_task/src/core/other/usecase.dart';
import 'package:swim_success_test_task/src/features/pace_selector/domain/repositories/pace_selector_repository.dart';

class PostPaceSecondsUseCase extends Functions1<int, void> {
  final PaceSelectorRepository _paceSelectorRepository;

  PostPaceSecondsUseCase({required this._paceSelectorRepository});

  @override
  Future<void> perform(int paceSeconds) async {
    await _paceSelectorRepository.postPaceSeconds(paceSeconds: paceSeconds);
  }
}
