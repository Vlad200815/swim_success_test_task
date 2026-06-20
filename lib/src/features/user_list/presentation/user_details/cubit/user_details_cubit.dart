import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/entities.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/usecases/fetch_user_by_id_usecase.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final FetchUserByIdUseCase _fetchUserByIdUseCase;

  UserDetailsCubit({required this._fetchUserByIdUseCase})
    : super(UserDetailsInitialState());

  Future<void> fetchUserById({required int userId}) async {
    emit(UserDetailsLoadingState());
    try {
      final result = await _fetchUserByIdUseCase.perform(userId);
      emit(UserDetailsSuccessState(user: result));
    } catch (e) {
      emit(UserDetailsFailureState(message: e.toString()));
    }
  }
}
