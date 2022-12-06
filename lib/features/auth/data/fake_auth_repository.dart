import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.dart';

@LazySingleton(as: AuthRepository)
@test
class FakeAuthRepository extends Mock implements AuthRepository {}
