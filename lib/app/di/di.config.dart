// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tryhard_showcase/app/data/auth/auth.dart' as _i3;
import 'package:tryhard_showcase/app/data/auth/auth_service.dart' as _i4;
import 'package:tryhard_showcase/app/data/datasource/db.dart' as _i8;
import 'package:tryhard_showcase/app/data/datasource/db_client.dart' as _i9;
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart'
    as _i5;
import 'package:tryhard_showcase/features/auth/data/fake_auth_repository.dart'
    as _i7;
import 'package:tryhard_showcase/features/auth/data/real_auth_repository.dart'
    as _i6;
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart'
    as _i13;
import 'package:tryhard_showcase/features/profile/data/fake_user_repository.dart'
    as _i12;
import 'package:tryhard_showcase/features/profile/data/real_user_repository.dart'
    as _i11;
import 'package:tryhard_showcase/features/profile/data/user_repository.dart'
    as _i10;

const String _prod = 'prod';
const String _test = 'test';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthApi>(
      () => _i4.FirebaseAuthService(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i5.AuthRepository>(
      () => _i6.RealAuthRepository(auth: gh<_i3.AuthApi>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i5.AuthRepository>(
      () => _i7.FakeAuthRepository(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i8.Database>(
      () => _i9.FirebaseApiService(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i10.UserRepository>(
      () => _i11.RealUserRepository(db: gh<_i8.Database>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i10.UserRepository>(
      () => _i12.FakeUserRepository(),
      registerFor: {_test},
    );
    gh.singleton<_i13.AuthCubit>(
      _i13.AuthCubit(
        gh<_i5.AuthRepository>(),
        gh<_i10.UserRepository>(),
      ),
      registerFor: {
        _prod,
        _test,
      },
    );
    return this;
  }
}
