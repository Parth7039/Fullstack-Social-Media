import 'package:flutter/material.dart';
import 'package:social_media_fullstack/features/auth/presentation/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailcontroller = TextEditingController();
  final pwcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Icon(Icons.lock_open_rounded, size: 80,),
                  const SizedBox(height: 50,),
                  MyTextField(controller: emailcontroller, hintText: 'Enter Email', obscureText: false),
                  const SizedBox(height: 50,),
                  MyTextField(controller: pwcontroller, hintText: 'Enter password', obscureText: true),
                ],
              ),
            ),
          )
      ),
    );
  }
}
