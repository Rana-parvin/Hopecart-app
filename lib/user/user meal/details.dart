import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20meal/meal%20class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  final Mealclass item;
  const Details({super.key, required this.item});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  File? get filePath => null;

  @override
  void initState() {
    getData();
    super.initState();
  }

  String? userKey;

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
title: Text(
          "Meal Details",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),     
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Icon(
                    Icons.fastfood,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 45,
                  ),
                ),
                Text(
                  "item in detail",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Support a good cause",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 194, 176, 225),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 200,
                    width: 220,
                    child: Image.asset(
                      "assets/images/meal.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Column(
                  children: [
                    Text(
                      widget.item.name,
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "₹${widget.item.price} only",
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Container(
                  height: screenheight * 0.2,
                  width: screenwidth * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 15,
                          bottom: 7,
                        ),
                        child: Text(
                          "Description:",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 15,
                          top: 7,
                        ),
                        child: Text("${widget.item.description}."),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    formbutton(
                      height: 50,
                      width: screenwidth * 0.42,
                      text: "Buy Now ",
                      onpressed: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //   ),
                        // );
                      },
                    ),
                    formbutton(
                      height: 50,
                      width: screenwidth * 0.42,
                      text: "Done",
                      onpressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    //for saving their viewed craft details
    //retreive the current userid or email
    var obtainedemail = sharedprefs.getString('user_id');

    setState(() {
      //store retreived id or email in userkey
      userKey = obtainedemail;
    });
    print('thisis service  value $userKey');
  }
}
