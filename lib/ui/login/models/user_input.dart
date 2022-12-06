import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [
        email,
        password,
        name,
        isTrainer,
      ];
}
