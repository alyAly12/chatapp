

import 'package:chity/firebase_options.dart';
import 'package:chity/screens/chat_page.dart';
import 'package:chity/screens/login_screen.dart';
import 'package:chity/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ChitChat());
}

class ChitChat extends StatelessWidget {
  const ChitChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id:(context)=>  const LoginScreen(),
        RegisterPage.id:(context)=> RegisterPage(),
        ChatPage.id:(context)=> ChatPage()
      },
      initialRoute: LoginScreen.id,

    );
  }
}

