part of 'user_list_bloc.dart';

@immutable
sealed class UserListState {}

final class UserListInitialState extends UserListState {}

final class UserListSuccessState extends UserListState {
  final List<UserEntity> users;

  UserListSuccessState({required this.users});
}

final class UserListFailureState extends UserListState {
  final String message;

  UserListFailureState({required this.message});
}

final class UserListLoadingState extends UserListState {}
