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
    return Scaffold(
      bottomNavigationBar: GNav(
        curve: Curves.easeInOutCubicEmphasized,
        color: Theme.of(context).colorScheme.secondary,
        gap: 8,
        activeColor: Colors.white,
        tabBackgroundColor: Theme.of(context).colorScheme.secondary,
        selectedIndex: selectedindex,
        onTabChange: (value) {
          setState(() {
            selectedindex = value;
          });
        },
        tabs: [
          GButton(icon: Icons.home_rounded, text: "Home"),
          GButton(icon: Icons.saved_search_sharp, text: "Explore"),
          GButton(icon: Icons.notifications_active, text: "Orders"),
          GButton(icon: Icons.settings, text: "Settings"),
        ],
      ),
      body: pages[selectedindex],
    );
  }
}
