import 'package:tryhard_showcase/data/repositories/user/models/user.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user_info_basic.dart';

abstract class UserGroupApi {
  Future<void> createUser({
    required UserRegistrationBasicInfo userInfo,
  });

  Future<UserProfile> getUserProfile({
    required String userGuid,
  });

  Future<void> updateUser({
    required UserProfile? user,
  });

  Future<void> deleteUser({
    required String userGuid,
  });
}
