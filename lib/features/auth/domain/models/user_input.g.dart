// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInput _$UserInputFromJson(Map<String, dynamic> json) => UserInput(
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      isTrainer: json['isTrainer'] as bool? ?? false,
    );

Map<String, dynamic> _$UserInputToJson(UserInput instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'isTrainer': instance.isTrainer,
    };
