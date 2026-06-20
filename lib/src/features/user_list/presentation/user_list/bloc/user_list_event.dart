part of 'user_list_bloc.dart';

@immutable
sealed class UserListEvent {}

final class OnFilteredByNamePressedEvent extends UserListEvent {}

final class FetchAllUserEvent extends UserListEvent with EquatableMixin {
  final bool isRefresh;

  FetchAllUserEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

final class SearchUsersEvent extends UserListEvent with EquatableMixin {
  final String query;

  SearchUsersEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

final class OnUserCardPressedEvent extends UserListEvent {}
