part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState.initial() = _ProfileStateInit;

  factory ProfileState.loading() = _ProfileStateLoading;

  factory ProfileState.loaded(UserProfile userProfile) = _ProfileStateLoaded;

  factory ProfileState.error(UserProfile? userProfile, String error) =
      _ProfileStateError;

  factory ProfileState.fromJson(Map<String, dynamic> json) =>
      _$ProfileStateFromJson(json);
}
