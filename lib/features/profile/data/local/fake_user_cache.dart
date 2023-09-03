import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/features/profile/data/local/user_cache.dart';

@LazySingleton(as: UserCache)
@test
class FakeUserCache extends Mock implements UserCache {}
