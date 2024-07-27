import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../infrastructure/model/user_model.dart';

class AuthState extends Equatable {
  final bool isLoadingSignUp;
  final bool isLoadingLogin;
  final UserModel? userModel;
  final User? user;

  const AuthState({this.isLoadingSignUp = false, this.isLoadingLogin = false, this.userModel, this.user});

  AuthState copyWith({
    bool? isLoadingSignUp,
    bool? isLoadingLogin,
    UserModel? userModel,
    User? user,
  }) {
    return AuthState(
      isLoadingSignUp: isLoadingSignUp ?? this.isLoadingSignUp,
      isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      userModel: userModel ?? this.userModel,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [
        isLoadingSignUp,
        isLoadingLogin,

      ];
}
