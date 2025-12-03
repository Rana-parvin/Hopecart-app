// BUTTON WIDGET 
import 'dart:ui';

import 'package:flutter/material.dart';

class formbutton extends StatelessWidget { 
  final String text; 
  final double height; 
  final double width;
   final dynamic Function() onpressed; 
  const formbutton({ super.key, required this.height, required this.text, required this.width, required this.onpressed, });
   @override
    Widget build(BuildContext context) { 
      return SizedBox( height: height, 
      width: width, 
      child: ElevatedButton( 
        style: ElevatedButton.styleFrom( 
          backgroundColor: Theme.of(context).colorScheme.secondary, 
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10), ), ), 
             onPressed: onpressed, child: Text( text, style: const TextStyle(color: Colors.white, fontSize: 15), ), ), ); } }