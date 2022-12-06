import 'dart:async';

import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';
import 'package:tryhard_showcase/data/repositories/auth/auth_repository.dart';
import 'package:tryhard_showcase/ui/login/models/user_input.dart';

class FakeAuthRepository implements AuthRepository {
  Map<UserInput, List<Completer<AuthException?>>> authLoginCompleters = {};
  List<Completer<AuthException?>> authGoogleCompleters = [];
  Map<UserInput, List<Completer<AuthException?>>> authRegisterCompleters = {};
  List<Completer<AuthException?>> authLogoutCompleters = [];

  final ValueNotifier<AuthUser?> _user = ValueNotifier(null);
  final ValueNotifier<bool> fakeIsLogged = ValueNotifier(false);

  void setFakeUser(AuthUser? user) {
    _user.value = user;
  }

  void setFakeIsLoggedTo(bool state) {
    fakeIsLogged.value = state;
  }

  @override
  void dispose() {}

  @override
  Future<void> googleLogIn() {
    authGoogleCompleters.add(Completer());
    return authGoogleCompleters.last.future;
  }

  @override
  ValueListenable<bool> get isLogged => fakeIsLogged;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) {
    final Completer<AuthException?> completer = Completer();
    authLoginCompleters[UserInput(
      email: email,
      password: password,
    )] = [
      ...?authLoginCompleters[UserInput(
        email: email,
        password: password,
      )],
      completer,
    ];
    return completer.future;
  }

  @override
  Future<void> logout() {
    authLogoutCompleters.add(Completer());
    return authLogoutCompleters.last.future;
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) {
    final Completer<AuthException?> completer = Completer();
    authRegisterCompleters[UserInput(
      email: email,
      password: password,
    )] = [
      ...?authRegisterCompleters[UserInput(
        email: email,
        password: password,
      )],
      completer,
    ];
    return completer.future;
  }

  @override
  ValueListenable<AuthUser?> get user => _user;
}
