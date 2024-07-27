import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../ui/comments_screen/comments_screen.dart';
import '../../ui/login_screen/login_screen.dart';
import '../../ui/signup_screen/sign_up_screen.dart';
import '../../ui/splash_screen/splash_screen.dart';
import 'app_navigation.dart';

class NamedRoutes {
  static final currentUser = FirebaseAuth.instance.currentUser;
  static final NamedRoutes _singleton = NamedRoutes._internal();

  NamedRoutes._internal();

  factory NamedRoutes() {
    return _singleton;
  }

  static ValueNotifier<dynamic> changeListener = ValueNotifier(null);

  static const loginScreen = '/loginScreen';
  static const signupScreen = '/signupScreen';
  static const splashScreen = '/splashScreen';
  static const commentsScreen = '/commentsScreen';

  static final GoRouter router = GoRouter(
    refreshListenable: changeListener,
    navigatorKey: AppNavigator.navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: splashScreen.parsePath,
        name: splashScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: loginScreen.parsePath,
        name: loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: signupScreen.parsePath,
        name: signupScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: commentsScreen.parsePath,
        name: commentsScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const CommentsScreen();
        },
      ),
    ],
  );
}

extension PathRoute on String {
  String get parsePath {
    switch (this) {
      case NamedRoutes.splashScreen:
        return '/';
      case NamedRoutes.loginScreen:
        return '/loginScreen';
      case NamedRoutes.signupScreen:
        return '/signupScreen';
      case NamedRoutes.commentsScreen:
        return '/commentsScreen';
      default:
        return '/unknown';
    }
  }
}
