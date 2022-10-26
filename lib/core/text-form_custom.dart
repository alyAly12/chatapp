import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
   CustomField({Key? key, required this.title, required this.label,this.onChange,this.validate}) : super(key: key);
final String title;
final String label;
Function(String)?onChange;
 String? Function(String?)?validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        hintText: title,
        helperStyle: TextStyle(
            color: Colors.grey.shade500
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
