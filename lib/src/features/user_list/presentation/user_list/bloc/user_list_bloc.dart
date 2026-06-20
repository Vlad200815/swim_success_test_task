import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/entities.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/usecases/fetch_all_users_usecase.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final FetchAllUsersUseCase _fetchAllUsersUseCase;

  UserListBloc({required this._fetchAllUsersUseCase})
    : super(UserListInitialState()) {
    on<FetchAllUserEvent>(_onFetchAllUsers);
  }

  Future<void> _onFetchAllUsers(
    FetchAllUserEvent event,
    Emitter<UserListState> emit,
  ) async {
    emit(UserListLoadingState());
    try {
      final List<UserEntity> users = await _fetchAllUsersUseCase.perform();
      debugPrint("Users: $users");
      emit(UserListSuccessState(users: users));
    } catch (e) {
      emit(UserListFailureState(message: e.toString()));
    }
  }
}
