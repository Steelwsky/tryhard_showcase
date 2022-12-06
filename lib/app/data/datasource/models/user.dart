import 'dart:ui';

import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:uuid/uuid.dart';

class UserProfile {
  UserProfile({
    required this.guid,
    required this.email,
    required this.searchId,
    this.name,
    this.emailVerified,
    this.color,
    this.myColor,
    this.isTrainer,
    this.linkedClients,
    this.linkedTrainers,
    this.phoneNumber,
    this.photoUrl,
  });

  //UserInfo
  final String guid;
  final String? searchId;
  final String? name;
  final String? email;

  final bool? emailVerified;
  final Color? color;
  final Color? myColor;
  final bool? isTrainer;
  final List<String>? linkedClients;
  final List<String>? linkedTrainers;
  final String? phoneNumber;
  final String? photoUrl;

  factory UserProfile.test() {
    return UserProfile(
      guid: const Uuid().v4(),
      email: 'foobar@testemail.com',
      searchId: '123456677898',
      name: 'FooAppTest',
      isTrainer: false,
    );
  }

  UserProfile copyWith({
    final int? resultResponse,
    final String? descriptionResponse,
    final String? guid,
    final String? searchId,
    final String? name,
    final String? email,
    final bool? emailVerified,
    final Color? color,
    final Color? myColor,
    final bool? isTrainer,
    final List<String>? linkedClients,
    final List<String>? linkedTrainers,
    final String? phoneNumber,
    final String? photoUrl,
  }) {
    return UserProfile(
      guid: guid ?? this.guid,
      searchId: searchId ?? this.searchId,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      color: color ?? this.color,
      myColor: myColor ?? this.myColor,
      isTrainer: isTrainer ?? this.isTrainer,
      linkedClients: linkedClients ?? this.linkedClients,
      linkedTrainers: linkedTrainers ?? this.linkedTrainers,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    guid: json['guid'],
        searchId: json['searchId'],
        name: json['name'] ?? 'Unknown',
        email: json['email'],
        emailVerified: json['emailVerified'],
        color: json['color'] != null ? Color(json['color']) : AppColors.primary,
        myColor: json['myColor'] != null
            ? Color(json['myColor'])
            : AppColors.primary,
        isTrainer: json['isTrainer'] ?? false,
        linkedClients: json['linkedClients'] != null
            ? List<String>.from(
                json["linkedClients"].map((x) => x),
              )
            : [],
        linkedTrainers: json['linkedTrainers'] != null
            ? List<String>.from(
                json["linkedTrainers"].map((x) => x),
              )
            : [],
        phoneNumber: json['phoneNumber'],
        photoUrl: json['photoUrl'],
      );

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'searchId': searchId,
      'name': (name?.isEmpty ?? true) ? 'Unknown' : name!,
      'email': email,
      'emailVerified': emailVerified,
      'color': color?.value,
      'myColor': myColor?.value,
      'isTrainer': isTrainer ?? false,
      'linkedClients': linkedClients != null
          ? List<String>.from(linkedClients!.map(
              (x) => x,
            ))
          : null,
      'linkedTrainers': linkedTrainers != null
          ? List<String>.from(
              linkedTrainers!.map((x) => x),
            )
          : null,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    };
  }
}
