import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnAuthCheck extends AuthEvent {
  final User? user;

  OnAuthCheck({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

class OnSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  OnSignUp({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

class OnLogin extends AuthEvent {
  final String email;
  final String password;

  OnLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
