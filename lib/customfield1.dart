import 'package:flutter/material.dart';

class customfield1 extends StatelessWidget {
  // final TextEditingController _name;
  final TextEditingController controller;
  final void Function()? ontap;
  final String? Function(String?) validator;
  final Icon? prefixicon;
  final TextInputType? keyboardtype;
  final BorderRadius borderRadius;
  final String hinttext;
  const customfield1({
    this.keyboardtype,
    super.key,
    required this.validator,
    this.ontap,
    this.prefixicon,
    required this.controller,
    required this.hinttext,
    required this.borderRadius,
    // required TextEditingController name,
  });
  // : _name = name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        onTap: ontap,
        controller: controller,
        keyboardType: keyboardtype,
        validator: validator,
        onSaved: (name) {},
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixicon,
          prefixIconColor: Theme.of(context).colorScheme.secondary,
          hintText: hinttext,
         // hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          //   contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
        ),
      ),
    );
  }
}
