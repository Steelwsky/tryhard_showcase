import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/ui/components/avatar.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/app/utils/toast.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/profile/domain/profile_cubit.dart';

class ProfileOverviewScreen extends StatelessWidget {
  const ProfileOverviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: kOverviewScreen,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const _UserProfileInitial(),
                  loading: () => const CircularProgressIndicator(),
                  loaded: (userProfile) =>
                      _UserProfileOverview(userProfile: userProfile),
                  error: (userProfile, error) => userProfile == null
                      ? const _UserProfileInitial()
                      : _UserProfileOverview(userProfile: userProfile),
                );
              },
              listener: (context, state) {
                state.whenOrNull(
                  error: (_, error) => showServiceToast(error),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _UserProfileOverview extends StatelessWidget {
  const _UserProfileOverview({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  final UserProfile userProfile;

  final textStyle = const TextStyle(
    fontSize: 16,
  );

  final textButtonStyle = const TextStyle(
    fontSize: 16,
    color: AppColors.caution,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      key: kOverviewForm,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _spacer16,
        UserAvatar(
          photo: userProfile.photoUrl,
        ),
        _spacer64,
        Text(
          'Name: ${userProfile.name}',
          style: textStyle,
        ),
        Text(
          'Email: ${userProfile.email}',
          style: textStyle,
        ),
        _spacer32,
        TextButton(
          key: kLogoutButton,
          onPressed: () {
            context.read<ProfileCubit>().logout();
            context.read<AuthCubit>().logout();
          },
          child: Text(
            'Log out',
            style: textButtonStyle,
          ),
        ),
      ],
    );
  }
}

class _UserProfileInitial extends StatelessWidget {
  const _UserProfileInitial({
    Key? key,
  }) : super(key: key);

  final textStyle = const TextStyle(
    fontSize: 16,
  );

  final textButtonStyle = const TextStyle(
    fontSize: 16,
    color: AppColors.secondary,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      key: kOverviewFormInitial,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _spacer16,
        const UserAvatar(),
        _spacer64,
        Text(
          'Name: ...',
          style: textStyle,
        ),
        Text(
          'Email: ...',
          style: textStyle,
        ),
        _spacer32,
        TextButton(
          onPressed: () => context.read<ProfileCubit>().loadUserProfile(context
                  .read<AuthCubit>()
                  .state
                  .whenOrNull(authorized: (user) => user.userGuid) ??
              "-1"),
          child: Text(
            'Reload',
            style: textButtonStyle,
          ),
        ),
      ],
    );
  }
}

const Widget _spacer16 = SizedBox(
  height: 16,
);

const Widget _spacer32 = SizedBox(
  height: 32,
);

const Widget _spacer64 = SizedBox(
  height: 64,
);
