import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/user/user%20donation/add%20donation.dart';
import 'package:hopecart/user/user%20donation/user%20view%20donation.dart';
import 'package:hopecart/user/user%20event/userviewevent.dart';
import 'package:hopecart/user/user%20food/viewbookedfd.dart';
import 'package:hopecart/user/user%20meal/view%20items.dart';
import 'package:hopecart/user/user%20craft/usercraftview.dart';
import 'package:hopecart/user/user%20craft/view%20cart.dart';
import 'package:hopecart/user/user%20order/vieworders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  String? userKey;
  String? uname;

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  Future getValidationData() async {
    final prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    setState(() {
      userKey = username;
      uname = username ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
  //  var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const UserDrawer(),
      appBar: AppBar(centerTitle: true,
       // backgroundColor: Colors.deepOrange,
        // title: Text(
        //   "Dashboard",
        //   style: GoogleFonts.petrona(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 22,
        //     color: const Color(0xFF76421E),
        //   ),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewCart()),
              );
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Stack(
                  alignment: Alignment(1, -1.1),
                  children: const [
                    Icon(Icons.home_rounded, size: 60, color: Color(0xFFF47C2C)),
                    Icon(Icons.favorite, size: 20, color: Color(0xFFF47C2C)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Welcome, $uname",
                style: GoogleFonts.openSans(
                    fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Text(
                "Together, we can make a difference",
                style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 25),

              // Dashboard grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DashboardTile(
                      title: "Events",
                      icon: Icons.event,
                      color: Colors.deepOrange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserViewEvents(showappbar: true,)),
                        );
                      }),
                  DashboardTile(
                      title: "Crafts",
                      icon: Icons.handyman,
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Usercraftview(showappbar: true,)),
                        );
                      }),
                  DashboardTile(
                      title: "Donations",
                      icon: Icons.attach_money,
                      color: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ViewDonation(showappbar: true,)),
                        );
                      }),
                  DashboardTile(
                      title: "Meals",
                      icon: Icons.fastfood,
                      color: Colors.redAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Viewbookedfd()),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Single Dashboard Tile
class DashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}

// Drawer
class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFF47C2C)),
            child: Center(
              child: Text(
                'MENU',
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          DrawerItem(title: "Events", icon: Icons.event, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserViewEvents(showappbar: true,)),
            );
          }),
          DrawerItem(title: "Add Donations", icon: Icons.attach_money, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddDonation()));
          }),
          DrawerItem(title: "View Donations", icon: Icons.money, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDonation(showappbar: true,)));
          }),
          DrawerItem(title: "Meals", icon: Icons.fastfood, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Viewitems(showappbar: true,)));
          }),
          DrawerItem(title: "Crafts", icon: Icons.handyman, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Usercraftview(showappbar: true,)));
          }),
          DrawerItem(title: "Orders", icon: Icons.shopping_bag, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
          }),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItem(
      {super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFF47C2C)),
      title: Text(
        title,
        style: GoogleFonts.nunito(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
      onTap: onTap,
    );
  }
}
