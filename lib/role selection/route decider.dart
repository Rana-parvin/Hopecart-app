import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hopecart/role selection/index.dart';
import 'package:hopecart/user/usersplash.dart';
import 'package:hopecart/admin/adminsplash.dart';



class RouteDecider extends StatefulWidget {
  const RouteDecider({super.key});

  @override
  State<RouteDecider> createState() => _RouteDeciderState();
}

class _RouteDeciderState extends State<RouteDecider> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString("user_id");
    final admin = prefs.getString("get_id");

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Usersplash()));
    } else if (admin != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AdminSplashScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const indexwid()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
