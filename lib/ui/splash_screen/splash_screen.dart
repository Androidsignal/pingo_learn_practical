import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingo_learn_practical/infrastructure/app_routes/app_navigation.dart';
import 'package:pingo_learn_practical/ui/signup_screen/bloc/auth_bloc.dart';
import 'package:pingo_learn_practical/ui/signup_screen/bloc/auth_state.dart';

import '../../infrastructure/app_routes/name_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.user != null) {
            AppNavigator.toRemoveAllName(NamedRoutes.commentsScreen);
          } else {
            AppNavigator.toRemoveAllName(NamedRoutes.signupScreen);
          }
        },
        child: Center(
          child: Image.asset(
            "assets/img.png",
            fit: BoxFit.fill,
            scale: 1.5,
          ),
        ),
      ),
    );
  }
}
