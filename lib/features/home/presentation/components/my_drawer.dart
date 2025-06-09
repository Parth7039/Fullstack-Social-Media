import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:social_media_fullstack/features/auth/presentation/cubits/auth_cubit.dart';

import '../../../profile/presentation/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Fetch username from Firestore
  Future<String> getUserName() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    return userDoc['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FutureBuilder<String>(
                future: getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 40, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        JumpingDotsProgressIndicator(fontSize: 30, milliseconds: 200,),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Column(
                      children: const [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 40, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Text("Error loading name", style: TextStyle(color: Colors.white)),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 40, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data ?? "No Name",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            // Drawer Tiles
            Expanded(
              child: ListView(
                children: [
                  MyDrawerTile(title: "H O M E", icon: Icons.home, onTap: () {
                    Navigator.pop(context);
                  }),
                  MyDrawerTile(title: "P R O F I L E", icon: Icons.person, onTap: () {
                    Navigator.pop(context);
                    final user = context.read<AuthCubit>().currentUser;
                    String? uid = user!.uid;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(uid: uid)));
                  }),
                  MyDrawerTile(title: "S E T T I N G S", icon: Icons.settings, onTap: () {
                    Navigator.pop(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                  }),
                  MyDrawerTile(title: "S E A R C H", icon: Icons.settings, onTap: () {
                    Navigator.pop(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  }),
                  MyDrawerTile(title: "L O G O U T", icon: Icons.logout, onTap: () {
                    context.read<AuthCubit>().logout();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const MyDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      tileColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.1),
    );
  }
}
