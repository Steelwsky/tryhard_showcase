import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';

abstract interface class UserInteractor {
  Future<void> createUser({required UserRegistrationBasicInfo userBasicInfo});

  Future<UserProfile> getUserProfile({required String userGuid});
}
