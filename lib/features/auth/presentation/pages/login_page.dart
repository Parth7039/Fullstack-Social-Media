import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_fullstack/features/auth/presentation/components/text_field.dart';
import 'package:social_media_fullstack/features/auth/presentation/pages/register_page.dart';

import '../cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {

  final void Function()? togglePages;

  const LoginPage({super.key, required this.togglePages});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  final emailcontroller = TextEditingController();
  final pwcontroller = TextEditingController();

  void login(){
    final String email = emailcontroller.text;
    final String  pw = pwcontroller.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && pw.isNotEmpty){
      authCubit.login(email, pw);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter both email and password')));
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    pwcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/login_logo.png',scale: 3,),
                  const SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        Text('Login', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        MyTextField(controller: emailcontroller, hintText: 'Email', obscureText: false, prefixIcon: Icons.email_outlined,),
                        const SizedBox(height: 20,),
                        MyTextField(controller: pwcontroller, hintText: 'Password', obscureText: true, prefixIcon: Icons.password,),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: widget.togglePages,
                                child: Text('Register here!!', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),

                            TextButton(onPressed: (){}, child: Text('Forgot Password!!',style: TextStyle(color: Colors.black),)),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            elevation: 4,
                            shadowColor: Theme.of(context).shadowColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
