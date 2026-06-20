part of 'user_list_bloc.dart';

@immutable
sealed class UserListEvent {}

final class PullToRefreshEvent extends UserListEvent {}

final class OnFilteredByNamePressedEvent extends UserListEvent {}

final class FetchAllUserEvent extends UserListEvent {}
