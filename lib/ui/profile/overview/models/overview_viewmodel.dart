import 'package:equatable/equatable.dart';

class ProfileOverviewViewModel extends Equatable {
  final String? name;
  final String? photoUrl;
  final String? email;

  const ProfileOverviewViewModel.data({
    required this.name,
    this.photoUrl,
    required this.email,
  });

  const ProfileOverviewViewModel.empty()
      : name = null,
        email = null,
        photoUrl = null;

  @override
  List<Object?> get props => [
        name,
        email,
        photoUrl,
      ];
}
