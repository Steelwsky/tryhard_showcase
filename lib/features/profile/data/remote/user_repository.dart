import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';

abstract class UserRepository {
  Future<UserProfile> getUserProfile({
    required String userGuid,
  });

  Future<void> createUserProfile({
    required UserRegistrationBasicInfo userBasicInfo,
  });

  Future<void> deleteUserProfile({
    required String userGuid,
  });
}
