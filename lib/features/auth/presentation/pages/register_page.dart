import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_fullstack/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_fullstack/features/auth/presentation/pages/login_page.dart';

import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailcontroller = TextEditingController();
  final pwcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final confirmpwcontroller = TextEditingController();

  void register() {
    final String name = namecontroller.text;
    final String email = emailcontroller.text;
    final String pw = pwcontroller.text;
    final String confirmPw = confirmpwcontroller.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && name.isNotEmpty && pw.isNotEmpty && confirmPw.isNotEmpty){
      if (pw == confirmPw){
        authCubit.register(name, email, pw);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('confirm password and password should match')));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('please complete all fields')));
    }
  }

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    pwcontroller.dispose();
    confirmpwcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
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
                          Text('Register', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          MyTextField(controller: namecontroller, hintText: 'Enter Full Name', obscureText: false, prefixIcon: Icons.person,),
                          const SizedBox(height: 20,),
                          MyTextField(controller: emailcontroller, hintText: 'Email', obscureText: false, prefixIcon: Icons.email_outlined,),
                          const SizedBox(height: 20,),
                          MyTextField(controller: pwcontroller, hintText: 'Password', obscureText: false, prefixIcon: Icons.password,),
                          const SizedBox(height: 20,),
                          MyTextField(controller: confirmpwcontroller, hintText: 'Confirm Password', obscureText: false, prefixIcon: Icons.password,),
                          const SizedBox(height: 10,),
                          ElevatedButton(
                            onPressed: register,
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
                            child: const Text('Register'),
                          ),
                          const SizedBox(height: 10,),
                          GestureDetector(
                              onTap: widget.togglePages,
                              child: Text('Already a member? Login now', style: TextStyle(color: Colors.black),))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
