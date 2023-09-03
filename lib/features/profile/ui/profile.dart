import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/constants/strings/user_guids.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/app/ui/components/avatar.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/app/utils/toast.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/profile/domain/cubit/profile_cubit.dart';
import 'package:tryhard_showcase/features/profile/domain/interactor/user_interactor.dart';

class ProfileOverviewScreen extends StatelessWidget {
  const ProfileOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(
        userInteractor: sl<UserInteractor>(),
      )..loadUserProfile(
          userGuid: sl<AuthRepository>().getCurrentUserId(),
        ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          key: kOverviewScreen,
          child: ProfileContentView(),
        ),
      ),
    );
  }
}

class ProfileContentView extends StatelessWidget {
  const ProfileContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
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
    );
  }
}

class _UserProfileOverview extends StatelessWidget {
  const _UserProfileOverview({required this.userProfile});

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
  const _UserProfileInitial();

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
          onPressed: () {
            context.read<ProfileCubit>().loadUserProfile(
                  userGuid: _getUserGuid(context),
                );
          },
          child: Text(
            'Reload',
            style: textButtonStyle,
          ),
        ),
      ],
    );
  }

  String _getUserGuid(BuildContext context) {
    final state = context.read<AuthCubit>().state;

    if (state is AuthAuthorizedState) {
      return state.user.userGuid ?? UserGuids.unknownGuid;
    }
    return UserGuids.unknownGuid;
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
