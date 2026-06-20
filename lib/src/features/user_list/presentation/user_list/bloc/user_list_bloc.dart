import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/entities.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/usecases/fetch_all_users_usecase.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

EventTransformer<Event> debounceTransformer<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final FetchAllUsersUseCase _fetchAllUsersUseCase;
  List<UserEntity> _allUsers = [];

  UserListBloc({required this._fetchAllUsersUseCase})
    : super(UserListInitialState()) {
    on<FetchAllUserEvent>(_onFetchAllUsers);
    on<SearchUsersEvent>(
      _onSearchUsers,
      transformer: debounceTransformer(const Duration(milliseconds: 350)),
    );
  }

  Future<void> _onFetchAllUsers(
    FetchAllUserEvent event,
    Emitter<UserListState> emit,
  ) async {
    emit(UserListLoadingState());
    try {
      if (event.isRefresh) {
        await Future.delayed(const Duration(milliseconds: 600));
      }

      final List<UserEntity> users = await _fetchAllUsersUseCase.perform();
      _allUsers = users;

      emit(UserListSuccessState(users: users));
    } catch (e) {
      emit(UserListFailureState(message: e.toString()));
    }
  }

  void _onSearchUsers(SearchUsersEvent event, Emitter<UserListState> emit) {
    if (state is UserListSuccessState) {
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        // Restore full cached list
        emit(UserListSuccessState(users: _allUsers, searchQuery: ''));
      } else {
        final filtered = _allUsers.where((user) {
          final userName = user.name?.toLowerCase() ?? '';
          return userName.contains(query);
        }).toList();

        emit(UserListSuccessState(users: filtered, searchQuery: event.query));
      }
    }
  }
}
