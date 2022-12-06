import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tryhard_showcase/data/api/auth/auth.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';

abstract class AuthRepository {
  ValueListenable<bool> get isLogged;

  ValueListenable<AuthUser?> get user;

  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> register({
    required String email,
    required String password,
  });

  Future<void> googleLogIn();

  Future<void> logout();

  void dispose();
}

class RealAuthRepository implements AuthRepository {
  RealAuthRepository({
    required AuthApi auth,
  }) : _auth = auth {
    _isLogged.addListener(_onLoggedOut);
  }

  late final AuthApi _auth;

  final ValueNotifier<bool> _isLogged = ValueNotifier(false);

  final ValueNotifier<AuthUser?> _user = ValueNotifier(null);

  @override
  ValueListenable<bool> get isLogged => _isLogged;

  @override
  ValueListenable<AuthUser?> get user => _user;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _user.value = await _auth.userLogin(
        email: email,
        password: password,
      );
      _isLogged.value = true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      _user.value = await _auth.userRegistration(
        email: email,
        password: password,
      );
      _isLogged.value = true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> googleLogIn() async {
    try {
      _user.value = await _auth.googleLogIn();
      _isLogged.value = true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.userLogout();
      _isLogged.value = false;
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

  void _onLoggedOut() {
    if (_isLogged.value == false) {
      _user.value = null;
    }
  }

  @override
  void dispose() {
    _isLogged.removeListener(_onLoggedOut);
  }
}
