part of 'user_list_bloc.dart';

@immutable
sealed class UserListEvent {}

final class OnFilteredByNamePressedEvent extends UserListEvent {}

final class FetchAllUserEvent extends UserListEvent {
  final bool isRefresh;

  FetchAllUserEvent({this.isRefresh = false});
}
