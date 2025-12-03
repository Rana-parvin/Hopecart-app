import 'package:flutter/material.dart';
import 'package:hopecart/role%20selection/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'HopeCart',
      theme: ThemeData( 
        useMaterial3: true,
        drawerTheme: DrawerThemeData(
          backgroundColor: const Color(0xFFFFF4E1), 
        ),
        appBarTheme: AppBarTheme(
          backgroundColor:const Color(0xFFFFF4E1)
        ),
        scaffoldBackgroundColor:const Color(0xFFFFF4E1),    
        colorScheme:ColorScheme.light(
          primary: const  Color(0xFFFFF4E1),
          secondary:const  Color(0xFFF47C2C),
        ),
      ),
      home:indexwid(),
    );
  }
}

//milkshakepage()
