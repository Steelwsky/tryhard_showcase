import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> register({
    required String email,
    required String password,
  });

  Future<AuthUser> googleLogIn();

  String getCurrentUserId();

  Future<void> logout();
}
