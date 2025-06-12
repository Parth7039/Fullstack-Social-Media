import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:social_media_fullstack/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_fullstack/features/profile/presentation/components/bio_box.dart';
import 'package:social_media_fullstack/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_fullstack/features/profile/presentation/cubits/profile_states.dart';

import '../../../auth/domain/entities/app_user.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {

  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileState>(
        builder: (context, state) {
          //loaded
          if (state is ProfileLoaded) {
            final user = state.profileUser;
            return Scaffold(
              appBar: AppBar(
                title: Text(user.name),
                actions: [
                  IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(user: user,))),
                      icon: Icon(Icons.settings)
                  )
                ],
              ),
              body: Center(
                child: Column(
                  children: [
                    Text(user.email),
                    Container(
                      decoration: BoxDecoration(),
                      child: Center(
                        child: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bio"),
                        const SizedBox(width: 10),
                        Expanded(
                          child: BioBox(text: user.bio),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Posts"),
                        const SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
              ),
            );
          }

          //loading
          else if (state is ProfileLoading) {
            return Scaffold(
              body: Center(
                child: JumpingDotsProgressIndicator(),
              ),
            );
          }

          //no profile found
          else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/profile_not_found.json', // Replace with your actual path
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No profile found',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}