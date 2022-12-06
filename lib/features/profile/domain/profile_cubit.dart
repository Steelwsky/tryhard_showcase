import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';

part 'profile_cubit.freezed.dart';

part 'profile_cubit.g.dart';

part 'profile_state.dart';

class ProfileCubit extends HydratedCubit<ProfileState> {
  ProfileCubit(
    this._authRepository,
    this._userRepository,
    this._authCubit,
  ) : super(ProfileState.initial()) {
    authSubscription = _authCubit.stream.listen((event) {
      event.mapOrNull(
        authorized: (_) => loadUserProfile(
          _authRepository.getCurrentUserId(),
        ),
        notAuthorized: (_) => logout(),
      );
    });
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthCubit _authCubit;
  late final StreamSubscription authSubscription;

  Future<void> loadUserProfile(String userGuid) async {
    try {
      emit(ProfileState.loading());
      final userProfile =
          await _userRepository.getUserProfile(userGuid: userGuid);
      emit(ProfileState.loaded(userProfile));
    } on ApiException catch (e) {
      emit(ProfileState.error(null, e.description));
    }
  }

  Future<void> logout() async {
    final user = state.whenOrNull(loaded: (user) => user);
    try {
      await _authCubit.logout();
      emit(ProfileState.initial());
    } on AuthException catch (e) {
      emit(ProfileState.error(user, e.message));
    }
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    return ProfileState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    return state.toJson();
  }
}
