import 'package:injectable/injectable.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';
import 'package:tryhard_showcase/features/profile/data/local/user_cache.dart';
import 'package:tryhard_showcase/features/profile/data/remote/user_repository.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/user_interactor.dart';

@Singleton(as: UserInteractor)
@prod
class RealUserInteractor implements UserInteractor {
  RealUserInteractor({
    required UserRepository userRepository,
    required UserCache userCache,
  })  : _userRepository = userRepository,
        _userCache = userCache;

  final UserRepository _userRepository;
  final UserCache _userCache;

  @override
  Future<void> createUser({
    required UserRegistrationBasicInfo userBasicInfo,
  }) async {
    try {
      await _userRepository.createUserProfile(userBasicInfo: userBasicInfo);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserProfile> getUserProfile({required String userGuid}) async {
    final cachedUser = await _userCache.getUser(userGuid: userGuid);
    if (cachedUser != null) return cachedUser;

    try {
      final profile = await _userRepository.getUserProfile(userGuid: userGuid);
      _userCache.saveUser(userProfile: profile);
      return profile;
    } catch (_) {
      rethrow;
    }
  }
}
