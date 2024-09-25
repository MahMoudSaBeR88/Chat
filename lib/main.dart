import 'package:chat/screens/chatPage.dart';
import 'package:chat/screens/login.dart';
import 'package:chat/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        Chatpage.id: (context) => Chatpage(),
      },
      initialRoute: Login.id,
    );
  }
}

