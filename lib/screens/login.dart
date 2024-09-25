import 'package:chat/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/showSnackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chatPage.dart';

class Login extends StatefulWidget {
  Login({super.key});

  static String id = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoggedIn,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 120,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: 'Email',
                  labelText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'Password',
                  labelText: 'Password',
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  buttonText: 'Log In',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoggedIn = true;
                      setState(() {});
                      try {
                        await LoginUser();
                        showSnackBar(context, 'Success');
                        Navigator.pushNamed(context, Chatpage.id ,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      }
                      isLoggedIn = false;
                      setState(() {});
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                      child: const Text(
                        '  Register',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
