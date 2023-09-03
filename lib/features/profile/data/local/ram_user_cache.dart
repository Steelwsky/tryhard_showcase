import 'package:injectable/injectable.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';

import 'user_cache.dart';

typedef _CacheUserProfile = ({DateTime updatedAt, UserProfile? userProfile});

@LazySingleton(as: UserCache)
@prod
class RamUserCache implements UserCache {
  _CacheUserProfile _cache = (updatedAt: DateTime.now(), userProfile: null);

  @override
  Future<UserProfile?> getUser({required String userGuid}) async {
    if (_cache.userProfile == null || _cache.updatedAt.isOld()) {
      return null;
    }
    return _cache.userProfile;
  }

  @override
  void saveUser({required UserProfile userProfile}) {
    _cache = (updatedAt: DateTime.now(), userProfile: userProfile);
  }
}

extension _DateTimeDifference on DateTime {
  bool isOld() =>
      isBefore(DateTime.now().subtract(const Duration(seconds: 30)));
}
