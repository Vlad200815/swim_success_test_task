part of 'user_details_cubit.dart';

@immutable
sealed class UserDetailsState {}

final class UserDetailsInitialState extends UserDetailsState {}

final class UserDetailsSuccessState extends UserDetailsState
    with EquatableMixin {
  final UserEntity user;

  UserDetailsSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UserDetailsFailureState extends UserDetailsState
    with EquatableMixin {
  final String message;

  UserDetailsFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class UserDetailsLoadingState extends UserDetailsState {}
