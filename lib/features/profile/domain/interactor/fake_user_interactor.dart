import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/user_interactor.dart';

@LazySingleton(as: UserInteractor)
@test
class FakeUserInteractor extends Mock implements UserInteractor {}
