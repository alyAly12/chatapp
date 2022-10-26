
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../authentication/create_email_password_auth.dart';
import '../core/custom_button.dart';
import '../core/text-form_custom.dart';
import 'chat_page.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static const String id = 'registerId';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  bool isLoading =false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff284461),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'images/speech-bubbles-305824_640.png',
                        fit: BoxFit.contain,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Chity Chat',
                    style:
                        GoogleFonts.pacifico(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Sign Up',
                      style:
                          GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomField(
                    title: 'enter e-mail',
                    label: 'E-mail',
                    validate: (data) {
                      if (data!.isEmpty) {
                        return 'field is required';
                      }
                      return null;
                    },
                    onChange: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomField(
                    title: 'enter password',
                    label: 'Password',
                    validate: (data) {
                      if (data!.isEmpty) {
                        return 'field is required';
                      }
                      return null;
                    },
                    onChange: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    text: 'Register',
                    fontSize: 20,
                    onPress: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading =true;
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                        setState(() {

                        });
                        try {
                          await signupMethod(email,password);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.white, fontSize: 15),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.white, fontSize: 15),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                        isLoading =false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'success',
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white, fontSize: 15),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        setState(() {

                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account ?',
                        style: GoogleFonts.aBeeZee(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, LoginScreen.id,arguments: email);
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 15, color: Colors.white),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
