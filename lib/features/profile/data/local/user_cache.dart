import 'package:tryhard_showcase/app/data/datasource/models/user.dart';

abstract interface class UserCache {
  void saveUser({required UserProfile userProfile});

  Future<UserProfile?> getUser({required String userGuid});
}
