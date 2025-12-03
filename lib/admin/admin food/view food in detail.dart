import 'package:flutter/material.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20food/view%20food%20book.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/button/formbutton.dart';

class Viewfoodindetail extends StatefulWidget {
  final User_model data_user;
  const Viewfoodindetail({super.key, required this.data_user});

  @override
  State<Viewfoodindetail> createState() => _FooddetailsState();
}

class _FooddetailsState extends State<Viewfoodindetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Stack(
                    alignment: Alignment(2.8, -3),
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 40,
                      ),
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 23,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  " Order Details",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Support a good cause",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  height: screenheight * 0.2,
                  width: screenwidth * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    Text(
                      "Name :",
                      style: GoogleFonts.adamina(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.data_user.name,
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    Text(
                      "Food Type :",
                      style: GoogleFonts.adamina(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.data_user.foodtype,
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    Text(
                      "Date:",
                      style: GoogleFonts.adamina(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.data_user.date,
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                      const SizedBox(height: 20,),
                formbutton(
                  height: screenheight / 20,
                  width: screenwidth / 1.5,
                  text: "Mark as read",
                  onpressed: () {},
                ),
                 const SizedBox(height: 20,),
                 formbutton(
                  height: screenheight / 20,
                  width: screenwidth / 1.5,
                  text: "Send a Message ",
                  onpressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
