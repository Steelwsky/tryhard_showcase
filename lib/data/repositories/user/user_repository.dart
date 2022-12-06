import 'package:flutter/foundation.dart';
import 'package:tryhard_showcase/data/api/datasource/db.dart';
import 'package:tryhard_showcase/data/api/datasource/groups/user.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:tryhard_showcase/data/repositories/auth/auth_repository.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user_info_basic.dart';

abstract class UserRepository {
  ValueListenable<UserProfile?> get userProfile;

  Future<void> getUserProfile({
    required String? userGuid,
  });

  Future<void> createUserProfile({
    required UserRegistrationBasicInfo userBasicInfo,
  });

  Future<void> deleteUserProfile();

  void dispose();
}

class RealUserRepository implements UserRepository {
  RealUserRepository({
    required Database db,
    required AuthRepository authRepository,
  })  : _userDb = db,
        _authRepository = authRepository {
    _authRepository.isLogged.addListener(disposeOnLoggedOut);
  }

  final UserGroupApi _userDb;
  final AuthRepository _authRepository;

  final ValueListenable<bool> _isLoggedIn = ValueNotifier(false);
  final ValueNotifier<UserProfile?> _userProfile = ValueNotifier(null);

  @override
  ValueListenable<UserProfile?> get userProfile => _userProfile;

  @override
  Future<void> createUserProfile({
    required UserRegistrationBasicInfo userBasicInfo,
  }) {
    try {
      return _userDb.createUser(
        userInfo: userBasicInfo,
      );
    } on ApiException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUserProfile() async {
    try {
      await _userDb.deleteUser(userGuid: userProfile.value!.guid);
      _authRepository.logout();
      _userProfile.value = null;
    } on ApiException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> getUserProfile({
    required String? userGuid,
  }) async {
    try {
      if (userGuid != null) {
        _userProfile.value = await _userDb.getUserProfile(userGuid: userGuid);
      } else {
        throw ApiException(
          code: 'no-user-guid',
          description: 'User ID is not set. Please try to log in again',
        );
      }
    } on ApiException catch (_) {
      _authRepository.logout();
      rethrow;
    }
  }

  void disposeOnLoggedOut() {
    if (_isLoggedIn.value == false) {
      dispose();
    }
  }

  @override
  void dispose() {
    _userProfile.value = null;
  }
}
