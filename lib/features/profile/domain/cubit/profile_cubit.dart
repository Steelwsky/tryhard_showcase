import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/user_interactor.dart';

part 'profile_cubit.freezed.dart';
part 'profile_cubit.g.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required UserInteractor userInteractor,
  })  : _userInteractor = userInteractor,
        super(ProfileState.initial());

  final UserInteractor _userInteractor;

  Future<void> loadUserProfile({required String userGuid}) async {
    emit(ProfileState.loading());
    try {
      final profile = await _userInteractor.getUserProfile(userGuid: userGuid);
      emit(ProfileState.loaded(profile));
    } on ApiException catch (e) {
      emit(ProfileState.error(null, e.description));
    }
  }
}
