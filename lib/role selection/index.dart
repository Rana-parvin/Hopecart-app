import 'package:flutter/material.dart';
import 'package:hopecart/admin/adminsplash.dart';
import 'package:hopecart/role%20selection/speech.dart';
import 'package:hopecart/user/registeruser.dart';
import 'package:google_fonts/google_fonts.dart';

class indexwid extends StatefulWidget {
  const indexwid({super.key});

  @override
  State<indexwid> createState() => _indexwidState();
}

class _indexwidState extends State<indexwid> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpeechPage()),
          );
        },
        tooltip: "Record Audio",
        child: Icon(Icons.mic_none_sharp,color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      appBar: AppBar(),
      backgroundColor: const Color(0xFFFFF4E1),
      body: Hero(
        tag: "",
        child: Center(
          child: Container(
            height: screenHeight * 0.9,
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFFFFFFFF),
                  child: Stack(
                    alignment: Alignment(1, -1.1),
                    children: [
                      Icon(
                        Icons.home_rounded,
                        size: 60,
                        color: const Color(0xFFF47C2C),
                      ),
                      Icon(
                        Icons.favorite,
                        size: 20,
                        color: const Color(0xFFF47C2C),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Orphanage E com",
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                 SizedBox(height: 5,),
                Text(
                  "Choose how you wanna contribute",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registeruser()),
                    );
                  },
                  child: Container(
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xFFF47C2C),
                          child: Icon(
                            Icons.person_rounded,
                            color: const Color(0xFFFFFFFF),
                            size: 30,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User',
                              style: GoogleFonts.overpass(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Make a splash,donate,\nbuy crafts and order meals.",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminSplashScreen()),
                    );
                  },
                  child: Container(
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xFFF47C2C),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Icon(
                                Icons.person_rounded,
                                color: const Color(0xFFFFFFFF),
                                size: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF47C2C),
                                ),
                                child: Icon(
                                  Icons.settings,
                                  color: const Color(0xFFFFFFFF),
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin',
                              style: GoogleFonts.overpass(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              " Curate content,add new\n features and manage users.",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
