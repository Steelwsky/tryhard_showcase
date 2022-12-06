import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:tryhard_showcase/app/data/auth/auth.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';

import 'auth_repository.dart';

@LazySingleton(as: AuthRepository)
@prod
class RealAuthRepository implements AuthRepository {
  RealAuthRepository({
    required AuthApi auth,
  }) : _auth = auth;

  late final AuthApi _auth;

  @override
  Future<AuthUser> login({required String email, required String password, x}) {
    try {
      return _auth.userLogin(
        email: email,
        password: password,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) {
    try {
      return _auth.userRegistration(
        email: email,
        password: password,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<AuthUser> googleLogIn() {
    try {
      return _auth.googleLogIn();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logout() {
    try {
      return _auth.userLogout();
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: e.message ?? 'An unknown error has occurred',
      );
    } catch (_) {
      throw AuthException(
        code: 'sign-out-error',
        message: 'An unknown error has occurred',
      );
    }
  }

  @override
  String getCurrentUserId() {
    return _auth.getCurrentUserId() ?? "-1";
  }
}
