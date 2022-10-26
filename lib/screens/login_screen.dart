import 'package:chity/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../authentication/create_email_password_auth.dart';
import '../core/custom_button.dart';
import '../core/text-form_custom.dart';
import 'chat_page.dart';


class LoginScreen extends StatefulWidget {
    const LoginScreen({Key? key,}) : super(key: key);

static  String id = 'loginId';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String? email;
   String? password;

    bool isLoading =false;

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff284461),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80,),
                  SizedBox(
                    height: 100,
                      width: 100,
                      child: Image.asset('images/speech-bubbles-305824_640.png',fit: BoxFit.contain,)),
                  const SizedBox(height: 30,),
                  Text(
                    'Chity Chat',
                    style: GoogleFonts.pacifico(
                      fontSize: 30,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Login',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(height:15,),
                   CustomField(title: 'enter e-mail', label: 'E-mail',
                     validate:(data){
                     if(data!.isEmpty){
                       return 'field is required';
                     }
                     return null;
                     } ,
                   ),
                  const SizedBox(height: 10,),
                   CustomField(title: 'enter password', label: 'Password',
                     validate:(data){
                       if(data!.isEmpty){
                         return 'field is required';
                       }
                       return null;
                     } ,
                   ),
                  const SizedBox(height: 50,),
                   CustomButton( text: 'Login', fontSize: 20,
                     onPress: () async{
                       if (formKey.currentState!.validate()) {
                         isLoading=true;
                         Navigator.pushNamed(context, ChatPage.id,arguments: email);
                         setState(() {
                         });

                         try{
                          loginMethod(email, password);

                         }
                         on FirebaseAuthException catch(e){
                           if(e.code== 'user-not-found'){
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content:
                               Text(e.toString(),
                                 style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15),
                               ),
                                 duration: const Duration(seconds: 2),
                               ),
                             );
                           }else if(e.code=='wrong-password'){
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content:
                               Text(e.toString(),
                                 style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15),
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
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an Account ?',style: GoogleFonts.aBeeZee(color: Colors.white),),
                      const SizedBox(width: 8,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                          child: Text('Register',style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.white),))
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

