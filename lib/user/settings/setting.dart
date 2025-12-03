import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
          "Settings",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 15),

            _sectionTitle("Account"),
            _tile(
              icon: Icons.person_rounded,
              title: "Profile",
              onTap: () {},
            ),
            _tile(
              icon: Icons.lock_rounded,
              title: "Change Password",
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
              icon: Icons.info_rounded,
              title: "About App",
              onTap: () {},
            ),

            // Spacer(flex: 20,),

            Center(
              child: GestureDetector(
                onTap: () {}, // <-- add logout functionality
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
          color: Color(0xFF76421E),
        ),
      ),
    );
  }

  Widget _tile({required IconData icon, required String title, required VoidCallback onTap}) {
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
            Icon(icon, size: 26, color: Color(0xFFF47C2C)),
            const SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
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
          Icon(icon, size: 26, color: Color(0xFFF47C2C)),
          const SizedBox(width: 15),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
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
