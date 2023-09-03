import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

import 'user_repository.dart';

@LazySingleton(as: UserRepository)
@test
class FakeUserRepository extends Mock implements UserRepository {}
