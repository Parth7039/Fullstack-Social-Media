import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_fullstack/features/auth/presentation/components/text_field.dart';
import 'package:social_media_fullstack/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_fullstack/features/profile/presentation/cubits/profile_states.dart';
import 'package:social_media_fullstack/features/profile/presentation/pages/profile_page.dart';

import '../../domain/entities/profile_user.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final bioTextController = TextEditingController();

  void updateProfile() async {
    final profileCubit = context.read();
    if (bioTextController.text.isNotEmpty) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state){
          return buildEditPage();
        },
        listener: (context, state) {},
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          IconButton(onPressed: updateProfile, icon: Icon(Icons.upload))
        ],
      ),
      body: Column(
        children: [
          Text("Bio"),
          MyTextField(
              controller: bioTextController,
              hintText: widget.user.bio,
              obscureText: false,
              prefixIcon: Icons.person_add_alt_1_outlined
          )
        ],
      ),
    );
  }

}
