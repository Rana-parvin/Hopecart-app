import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hopecart/user/bottom%20navigation/bottom%20nav.dart';
import 'package:hopecart/user/loginuser.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Usersplash extends StatefulWidget {
  const Usersplash({super.key});

  @override
  State<Usersplash> createState() => _UsersplashState();
}

class _UsersplashState extends State<Usersplash> {
  String? userKey;


  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  Future<void> checkUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userKey = prefs.getString('user_id');

    // Delay for showing splash
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => userKey == null ? const Loginuser() : const Bottomnav(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Color.fromARGB(255, 255, 186, 165),
                Color.fromARGB(255, 215, 141, 118),
              Color.fromARGB(255, 139, 84, 68)
  
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_rounded,
              size: 110,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            const Text(
              "HopeCart",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
