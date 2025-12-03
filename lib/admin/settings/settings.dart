import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSetting extends StatefulWidget {
  const AdminSetting({super.key});

  @override
  State<AdminSetting> createState() => _AdminSettingState();
}

class _AdminSettingState extends State<AdminSetting> {
  bool _notification = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Admin Settings",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
      ),

      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 15),

          _sectionTitle("Management"),
          _tile(
            icon: Icons.people_alt_rounded,
            title: "Users",
            onTap: () {},
          ),
          _tile(
            icon: Icons.shopping_bag_rounded,
            title: "Orders",
            onTap: () {},
          ),
          _tile(
            icon: Icons.fastfood_rounded,
            title: "Menu Items",
            onTap: () {},
          ),

          const SizedBox(height: 18),

          _sectionTitle("Preferences"),
          _switchTile(
            icon: Icons.notifications_active_rounded,
            title: "Notifications",
            value: _notification,
            onChanged: (v) => setState(() => _notification = v),
          ),
          _switchTile(
            icon: Icons.dark_mode_rounded,
            title: "Dark Mode",
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),

          const SizedBox(height: 18),

          _sectionTitle("Support"),
          _tile(
            icon: Icons.support_agent_rounded,
            title: "Help & Support",
            onTap: () {},
          ),
          _tile(
            icon: Icons.info_outline,
            title: "About App",
            onTap: () {},
          ),

          const SizedBox(height: 25),

          Center(
            child: GestureDetector(
              onTap: () {}, // Logout
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE04F4F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    ),
  ),
),

    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: const Color(0xFF76421E),
        ),
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 26, color: const Color(0xFFF47C2C)),
            const SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 26, color: const Color(0xFFF47C2C)),
          const SizedBox(width: 15),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Switch(
            activeThumbColor: const Color(0xFFF47C2C),
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
