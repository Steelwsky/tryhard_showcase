import 'package:flutter/material.dart';
import 'package:tryhard_showcase/ui/profile/overview/controllers/overview_controller.dart';
import 'package:tryhard_showcase/ui/profile/overview/models/overview_viewmodel.dart';
import 'package:tryhard_showcase/ui/shared/avatar.dart';
import 'package:tryhard_showcase/ui/styles/colors.dart';

class ProfileOverviewScreen extends StatelessWidget {
  const ProfileOverviewScreen({
    Key? key,
    required this.profileOverviewController,
  }) : super(key: key);

  final ProfileOverviewController profileOverviewController;

  final textStyle = const TextStyle(
    fontSize: 16,
  );

  final textButtonStyle = const TextStyle(
    fontSize: 16,
    color: AppColors.caution,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ValueListenableBuilder<ProfileOverviewViewModel>(
                valueListenable: profileOverviewController.viewModel,
                builder: (context, viewModel, __) {
                  if (viewModel == const ProfileOverviewViewModel.empty()) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    key: const ValueKey('overviewForm'),
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserAvatar(
                        photo: viewModel.photoUrl,
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Text(
                        'Name: ${viewModel.name}',
                        style: textStyle,
                      ),
                      Text(
                        'Email: ${viewModel.email}',
                        style: textStyle,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextButton(
                        key: const ValueKey('logoutButton'),
                        onPressed: profileOverviewController.logout,
                        child: Text(
                          'Log out',
                          style: textButtonStyle,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
