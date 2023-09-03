part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {}

final class AuthNotAuthorizedState extends AuthState {
  AuthNotAuthorizedState() : super();

  @override
  List<Object?> get props => [];
}

final class AuthErrorState extends AuthState {
  AuthErrorState({required this.message}) : super();

  final String message;

  @override
  List<Object?> get props => [message];
}

final class AuthAuthorizedState extends AuthState {
  AuthAuthorizedState({required this.user}) : super();

  final AuthUser user;

  @override
  List<Object?> get props => [user];
}
