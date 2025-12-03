import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hopecart/user/explore/explore.dart';
import 'package:hopecart/user/homeuser.dart';
import 'package:hopecart/user/settings/setting.dart';
import 'package:hopecart/user/user%20order/vieworders.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int selectedindex = 0;

  final List pages = [
    UserHome(),
    Explore(),
    MyOrders(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // IMPORTANT for floating glass effect
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18), // translucent glass
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: GNav(
                gap: 8,
                backgroundColor: Colors.transparent,
                color: Colors.white,
                activeColor: Colors.white,
                iconSize: 24,
                tabBorderRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

                tabBackgroundGradient: LinearGradient(
                  colors: [
                    Colors.deepOrange.withOpacity(0.7),
                    Colors.deepOrangeAccent.withOpacity(0.7),
                  ],
                ),

                selectedIndex: selectedindex,
                onTabChange: (value) {
                  setState(() {
                    selectedindex = value;
                  });
                },

                tabs: const [
                  GButton(icon: Icons.home_rounded, text: "Home"),
                  GButton(icon: Icons.card_giftcard_outlined, text: "Explore"),
                  GButton(icon: Icons.receipt_long_rounded, text: "Orders"),
                  GButton(icon: Icons.settings_rounded, text: "Settings"),
                ],
              ),
            ),
          ),
        ),
      ),
      body: pages[selectedindex],
    );
  }
}
