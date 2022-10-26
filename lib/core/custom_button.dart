import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
   const CustomButton({Key? key, required this.text, required this.fontSize, required this.onPress, }) : super(key: key);
final String text;
final double fontSize;
final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize:const Size (300,50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          )
      ),
      onPressed: onPress,
      child: Text(
          text,
        style: GoogleFonts.aBeeZee(fontSize:fontSize ),
      ),
    );
  }
}
