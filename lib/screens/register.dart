import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/showSnackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chatPage.dart';

class Register extends StatefulWidget {
  Register({super.key});

  static String id = "register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? password;

  bool isLoggedIn = false;

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
                      'Sign Up',
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
                  buttonText: 'Sign Up',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoggedIn = true;
                      setState(() {});
                      try {
                        await registerUser();
                        showSnackBar(context, 'Success');
                        Navigator.pushNamed(context, Chatpage.id ,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
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
                      'Already have account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '  Log In',
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

  Future<void> registerUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
