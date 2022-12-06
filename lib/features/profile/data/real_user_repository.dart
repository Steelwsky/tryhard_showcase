import 'package:injectable/injectable.dart';
import 'package:tryhard_showcase/app/data/datasource/db.dart';
import 'package:tryhard_showcase/app/data/datasource/groups/user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';

import 'user_repository.dart';

@LazySingleton(as: UserRepository)
@prod
class RealUserRepository implements UserRepository {
  RealUserRepository({
    required Database db,
  }) : _userDb = db;

  final UserGroupApi _userDb;

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
  Future<void> deleteUserProfile({
    required String userGuid,
  }) {
    try {
      return _userDb.deleteUser(userGuid: userGuid);
    } on ApiException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserProfile> getUserProfile({
    required String? userGuid,
  }) {
    try {
      if (userGuid != null) {
        return _userDb.getUserProfile(userGuid: userGuid);
      } else {
        throw ApiException(
          code: 'no-user-guid',
          description: 'User ID is not set. Please try to log in again',
        );
      }
    } on ApiException catch (_) {
      rethrow;
    }
  }
}
