import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hopecart/admin/admin%20order/admin%20view%20order.dart';
import 'package:hopecart/admin/homeadmin.dart';
import 'package:hopecart/admin/items/all%20items.dart';
import 'package:hopecart/admin/settings/settings.dart';

class Bottomnavig extends StatefulWidget {
  const Bottomnavig({super.key});

  @override
  State<Bottomnavig> createState() => _BottomnavigState();
}

class _BottomnavigState extends State<Bottomnavig> {
  int selectedindex = 0;

  final List pages = [
    admin_home(),
    Allitems(),
    Adminvieworder(),
    AdminSetting()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true, // makes background visible behind navbar
      body: pages[selectedindex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: GNav(
              curve: Curves.fastEaseInToSlowEaseOut,
              rippleColor: Colors.white.withOpacity(0.25),
              hoverColor: Colors.white.withOpacity(0.15),

              gap: 10,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),

              selectedIndex: selectedindex,
              onTabChange: (value) {
                setState(() {
                  selectedindex = value;
                });
              },

              backgroundColor: Colors.transparent,
              color: theme.colorScheme.secondary,
              activeColor: Colors.white,
              tabBackgroundColor: theme.colorScheme.secondary,

              tabs: const [
                GButton(icon: Icons.home_rounded, text: "Home"),
                GButton(icon: Icons.explore_rounded, text: "Explore"),
                GButton(icon: Icons.shopping_bag_rounded, text: "Orders"),
                GButton(icon: Icons.settings_rounded, text: "Settings"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
