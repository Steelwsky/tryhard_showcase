// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_form_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthFormState _$AuthFormStateFromJson(Map<String, dynamic> json) =>
    AuthFormState(
      inputs: UserInput.fromJson(json['inputs'] as Map<String, dynamic>),
      selectedFormType:
          $enumDecode(_$AuthFormTypeEnumMap, json['selectedFormType']),
      authButtonState:
          $enumDecode(_$AuthButtonStateEnumMap, json['authButtonState']),
      isPasswordHidden: json['isPasswordHidden'] as bool,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$AuthFormStateToJson(AuthFormState instance) =>
    <String, dynamic>{
      'inputs': instance.inputs,
      'selectedFormType': _$AuthFormTypeEnumMap[instance.selectedFormType]!,
      'authButtonState': _$AuthButtonStateEnumMap[instance.authButtonState]!,
      'isPasswordHidden': instance.isPasswordHidden,
      'errorMessage': instance.errorMessage,
    };

const _$AuthFormTypeEnumMap = {
  AuthFormType.login: 'login',
  AuthFormType.register: 'register',
};

const _$AuthButtonStateEnumMap = {
  AuthButtonState.loading: 'loading',
  AuthButtonState.disabled: 'disabled',
  AuthButtonState.enabled: 'enabled',
};
