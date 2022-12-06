import 'package:equatable/equatable.dart';

class UserRegistrationBasicInfo extends Equatable {
  const UserRegistrationBasicInfo._({
    required this.guid,
    required this.email,
    required this.searchId,
    this.name,
    this.isTrainer,
    this.photoUrl,
  });

  final String guid;
  final String email;
  final String searchId;
  final String? name;
  final bool? isTrainer;
  final String? photoUrl;

  UserRegistrationBasicInfo.create({
    required this.guid,
    required this.email,
    this.name,
    this.isTrainer = false,
    this.photoUrl,
  }) : searchId = guid.substring(0, 12);

  UserRegistrationBasicInfo copyWith({
    final String? guid,
    final String? email,
    final String? searchId,
    final String? name,
    final bool? isTrainer,
    final String? photoUrl,
  }) {
    return UserRegistrationBasicInfo._(
      guid: guid ?? this.guid,
      email: email ?? this.email,
      searchId: searchId ?? this.searchId,
      name: name ?? this.name,
      isTrainer: isTrainer ?? this.isTrainer,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'email': email,
      'searchId': searchId,
      'name': name,
      'isTrainer': isTrainer,
      'photoUrl': photoUrl,
    };
  }

  factory UserRegistrationBasicInfo.fromJson(Map<String, dynamic> json) =>
      UserRegistrationBasicInfo._(
        guid: json['guid'],
        email: json['email'],
        searchId: json['searchId'],
        name: json['name'] ?? 'Unknown',
        isTrainer: json['isTrainer'] ?? false,
        photoUrl: json['photoUrl'],
      );

  @override
  List<Object?> get props => [
        guid,
        email,
        searchId,
        name,
        isTrainer,
        photoUrl,
      ];
}
