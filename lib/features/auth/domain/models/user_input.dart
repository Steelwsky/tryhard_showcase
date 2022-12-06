import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_input.g.dart';

@JsonSerializable()
class UserInput extends Equatable {
  const UserInput({
    this.email,
    this.password,
    this.name,
    this.isTrainer = false,
  });

  final String? email;
  final String? password;
  final String? name;
  final bool isTrainer;

  UserInput copyWith({
    final String? email,
    final String? password,
    final String? name,
    final bool? isTrainer,
  }) {
    return UserInput(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      isTrainer: isTrainer ?? this.isTrainer,
    );
  }

  const UserInput.initial()
      : email = null,
        password = null,
        name = null,
        isTrainer = false;

  @override
  List<Object?> get props => [
        email,
        password,
        name,
        isTrainer,
      ];

  bool areInputsValid() {
    return (EmailValidator.validate(email ?? '')) &&
        (password?.isNotEmpty ?? false);
  }

  factory UserInput.fromJson(Map<String, dynamic> json) =>
      _$UserInputFromJson(json);

  Map<String, dynamic> toJson() => _$UserInputToJson(this);
}
