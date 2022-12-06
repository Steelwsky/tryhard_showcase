// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthStateNotAuthorized _$$_AuthStateNotAuthorizedFromJson(
        Map<String, dynamic> json) =>
    _$_AuthStateNotAuthorized(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_AuthStateNotAuthorizedToJson(
        _$_AuthStateNotAuthorized instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_AuthStateAuthorized _$$_AuthStateAuthorizedFromJson(
        Map<String, dynamic> json) =>
    _$_AuthStateAuthorized(
      AuthUser.fromJson(json['user'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_AuthStateAuthorizedToJson(
        _$_AuthStateAuthorized instance) =>
    <String, dynamic>{
      'user': instance.user,
      'runtimeType': instance.$type,
    };
