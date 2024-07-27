import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingo_learn_practical/infrastructure/repository/user_repository.dart';
import 'package:pingo_learn_practical/ui/signup_screen/bloc/auth_bloc.dart';
import 'package:pingo_learn_practical/ui/signup_screen/bloc/auth_event.dart';

import 'firebase_options.dart';
import 'infrastructure/app_routes/name_routes.dart';
import 'infrastructure/repository/auth_repository.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
              context.read<AuthRepository>(),
              context.read<UserRepository>(),
            )..add(OnAuthCheck(user: FirebaseAuth.instance.currentUser)),
          ),
        ],
        child: MaterialApp.router(
          title: 'PingoLearn Practical',
          theme: ThemeData(
            primaryColor: Color(0xFF0C54BE),
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0C54BE)),
            fontFamily: 'Poppins',
            useMaterial3: true,
            disabledColor: Color(0xFFCED3DC),
            scaffoldBackgroundColor: Color(0xFFF5F9FD),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF0C54BE)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          routerConfig: NamedRoutes.router,
        ),
      ),
    );
  }
}
