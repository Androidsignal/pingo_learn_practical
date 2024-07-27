import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/app_routes/app_navigation.dart';
import '../../../infrastructure/app_routes/name_routes.dart';
import '../../../infrastructure/model/user_model.dart';
import '../../../infrastructure/repository/auth_repository.dart';
import '../../../infrastructure/repository/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  StreamSubscription authStream = const Stream.empty().listen((event) {});

  AuthBloc(this.authRepository, this.userRepository) : super(const AuthState()) {
    on<OnAuthCheck>(_onAuthCheck);
    on<OnSignUp>(_onSignUp);
    on<OnLogin>(_onLogin);
  }

  Future<void> _onSignUp(OnSignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoadingSignUp: true));
    try {
      User? user = await authRepository.signUp(event.email, event.password, event.name);
      if (user != null) {
        await userRepository.setUser(
          model: UserModel(
            id: user.uid,
            email: event.email,
            name: event.name,
          ),
        );
        AppNavigator.toRemoveAllName(NamedRoutes.commentsScreen);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      AppNavigator.showSnackBar('Error', e.toString());
    }
    emit(state.copyWith(isLoadingSignUp: false));
  }

  Future<void> _onLogin(OnLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoadingLogin: true));
    try {
      User? user = await authRepository.login(event.email, event.password);
      if (user != null) {
        UserModel? userModel = await userRepository.getUser(id: user.uid);
        if (userModel != null) {
          emit(state.copyWith(userModel: userModel));
          AppNavigator.toRemoveAllName(NamedRoutes.commentsScreen);
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      AppNavigator.showSnackBar('Error', e.toString());
    }
    emit(state.copyWith(isLoadingLogin: false));
  }

  FutureOr<void> _onAuthCheck(OnAuthCheck event, Emitter<AuthState> emit) {
    emit(state.copyWith(user: event.user));
  }
}
