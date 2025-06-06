import 'package:flutter/material.dart';
import 'package:social_media_fullstack/features/auth/presentation/pages/login_page.dart';

import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailcontroller = TextEditingController();
  final pwcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final confirmpwcontroller = TextEditingController();

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
                        Text('Register', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        MyTextField(controller: namecontroller, hintText: 'Name', obscureText: false, prefixIcon: Icons.person,),
                        const SizedBox(height: 20,),
                        MyTextField(controller: emailcontroller, hintText: 'Email', obscureText: true, prefixIcon: Icons.email_outlined,),
                        const SizedBox(height: 20,),
                        MyTextField(controller: pwcontroller, hintText: 'Password', obscureText: false, prefixIcon: Icons.password,),
                        const SizedBox(height: 20,),
                        MyTextField(controller: confirmpwcontroller, hintText: 'Confirm Password', obscureText: false, prefixIcon: Icons.password,),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () {},
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
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        }, child: Text('Already a member? Login now', style: TextStyle(color: Colors.black),))
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
