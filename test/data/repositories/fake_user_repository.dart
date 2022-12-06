import 'dart:async';

import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user_info_basic.dart';
import 'package:tryhard_showcase/data/repositories/user/user_repository.dart';

typedef UserGuid = String;

class FakeUserRepository implements UserRepository {
  Map<UserRegistrationBasicInfo, List<Completer<ApiException?>>> createUserCompleters = {};
  Map<UserGuid?, List<Completer<ApiException?>>> getUserProfileCompleters = {};
  List<Completer<ApiException?>> deleteUserCompleters = [];

  UserProfile? _user;

  void setFakeUser(UserProfile? user) {
    _user = user;
  }

  @override
  Future<void> createUserProfile({
    required UserRegistrationBasicInfo userBasicInfo,
  }) {
    final Completer<ApiException?> completer = Completer();
    createUserCompleters[userBasicInfo] = [
      ...?createUserCompleters[userBasicInfo],
      completer,
    ];
    return completer.future;
  }

  @override
  Future<void> deleteUserProfile() async {
    return;
  }

  @override
  Future<void> getUserProfile({
    required String? userGuid,
  }) {
    final Completer<ApiException?> completer = Completer();
    getUserProfileCompleters[userGuid] = [
      ...?getUserProfileCompleters[userGuid],
      completer,
    ];
    return completer.future;
  }

  @override
  ValueListenable<UserProfile?> get userProfile => ValueNotifier(_user);

  @override
  void dispose() {}
}
