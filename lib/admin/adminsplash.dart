import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hopecart/admin/bottom%20navigaton/bottom%20navig.dart';
import 'package:hopecart/admin/login admin.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminSplashScreen extends StatefulWidget {
  const AdminSplashScreen({super.key});

  @override
  State<AdminSplashScreen> createState() => _AdminSplashScreenState();
}

class _AdminSplashScreenState extends State<AdminSplashScreen> {
  String? adminKey;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    adminKey = prefs.getString('get_id');

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => adminKey == null ? Loginadmin() : Bottomnavig(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.admin_panel_settings_rounded,
                size: 110,
                color: Colors.white,
              ),

              const SizedBox(height: 20),

              Text(
                "HopeCart Admin",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              const CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
