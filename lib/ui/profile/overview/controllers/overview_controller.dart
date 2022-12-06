import 'package:flutter/foundation.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:tryhard_showcase/data/repositories/auth/auth_repository.dart';
import 'package:tryhard_showcase/data/repositories/user/user_repository.dart';
import 'package:tryhard_showcase/ui/profile/overview/models/overview_viewmodel.dart';
import 'package:tryhard_showcase/ui/toast/controllers/toast_controller.dart';

abstract class ProfileOverviewController {
  ValueListenable<ProfileOverviewViewModel> get viewModel;

  Future<void> logout();

  void dispose();
}

class RealProfileOverviewController implements ProfileOverviewController {
  RealProfileOverviewController({
    required AuthRepository auth,
    required UserRepository userRepository,
    required ToastController toastController,
  })  : _auth = auth,
        _userRepository = userRepository,
        _toastController = toastController {
    _userRepository.userProfile.addListener(getCurrentUserProfile);
    loadUserProfile();
  }

  final AuthRepository _auth;
  final UserRepository _userRepository;
  final ToastController _toastController;
  final ValueNotifier<ProfileOverviewViewModel> _viewModel = ValueNotifier(
    const ProfileOverviewViewModel.empty(),
  );

  @override
  ValueListenable<ProfileOverviewViewModel> get viewModel => _viewModel;

  @override
  Future<void> logout() async {
    try {
      await _auth.logout();
    } on AuthException catch (e) {
      _toastController.setMessage(e.message);
    }
  }

  Future<void> loadUserProfile() async {
    try {
      return await _userRepository.getUserProfile(userGuid: _auth.user.value?.userGuid);
    } on ApiException catch (e) {
      _toastController.setMessage(e.description);
    }
  }

  void getCurrentUserProfile() {
    final profile = _userRepository.userProfile.value;
    _viewModel.value = ProfileOverviewViewModel.data(
      name: profile?.name,
      email: profile?.email,
      photoUrl: profile?.photoUrl,
    );
  }

  @override
  void dispose() {
    _userRepository.userProfile.removeListener(getCurrentUserProfile);
  }
}
