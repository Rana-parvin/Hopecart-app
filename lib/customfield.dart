import 'package:flutter/material.dart';

class customfield extends StatelessWidget {
  final String hinttext;
  final int? maxlines;
  final TextEditingController controller;
  final Icon prefixicon;
  final IconButton? suffixicon;
  final bool obscuretext;
  final bool? readonly;
  final TextInputType? keyboardtype;
  final String? Function(String?) validator;

  const customfield({
    super.key,
    //required this.padding
    required this.hinttext,
    required this.controller,
    required this.prefixicon,
    this.keyboardtype,
    this.readonly,
    required this.validator,
    required this.obscuretext,
    this.suffixicon,
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        readOnly: readonly ?? false,
        maxLines: maxlines,
        controller: controller,
        keyboardType: keyboardtype,
        obscureText: obscuretext,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hinttext,
          suffixIcon: suffixicon,
          prefixIcon: prefixicon,

          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIconColor: Color(0xFFF47C2C),
          suffixIconColor: Color(0xFFF47C2C),
        ),
      ),
    );
  }
}
