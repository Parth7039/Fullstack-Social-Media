import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_fullstack/features/auth/data/firebase_auth_repo.dart';
import 'package:social_media_fullstack/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_fullstack/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_media_fullstack/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_fullstack/themes/light_mode.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/profile/data/firebase_profile_repo.dart';

class MainApp extends StatelessWidget {

  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
          ),
          BlocProvider<ProfileCubit>(create: (context) => ProfileCubit(profileRepo: profileRepo)
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          home: BlocConsumer<AuthCubit, AuthState>(
            builder: (context, authState) {
              print(authState);
              if (authState is Unauthenticated) {
                return const AuthPage();
              }
              if (authState is Authenticated) {
                return const HomePage();
              }
              else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },

            //listen for any errors
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ),
    );
  }
}