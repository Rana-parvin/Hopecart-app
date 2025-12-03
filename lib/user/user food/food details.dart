import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/user/user%20food/viewbookedfd.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Fooddetails extends StatefulWidget {
  final Userfoods item;
  const Fooddetails({super.key, required this.item});

  @override
  State<Fooddetails> createState() => _FooddetailsState();
}

class _FooddetailsState extends State<Fooddetails> {
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
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Stack(
                    alignment: Alignment(0, -2.5),
                    children: [
                      Icon(
                        Icons.local_restaurant_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 27,
                      ),

                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 50,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Order Details",
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
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: screenheight * 0.2,
                  width: screenwidth * 0.5,
                  decoration: BoxDecoration(color: Colors.deepOrange),
                ),
                const SizedBox(height: 20),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    Text(
                      "Ordered by: ",
                      style: GoogleFonts.adamina(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    //   const SizedBox(width: 20),
                    Text(
                      widget.item.name,
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 //   const SizedBox(width: 50),
                    Text(
                      "Food: ",
                      style: GoogleFonts.adamina(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    //const SizedBox(width: 20),
                    Text(
                      widget.item.foodtype,
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 //   const SizedBox(width: 50),
                    Text(
                      "Ordered On:",
                      style: GoogleFonts.adamina(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    //     const SizedBox(width: 10),
                    Text(
                      widget.item.date,
                      style: GoogleFonts.taiHeritagePro(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  formbutton(
                      height: screenheight /15,
                      width: screenwidth * 0.4,              
                      text: "Ok",
                     onpressed: ()async{
                            Navigator.pop(context);
                  
                     } ,
                   ),

                    formbutton(
                      height: screenheight /15,
                      width: screenwidth * 0.4,              
                      text: "Cancel order",
                     onpressed: ()async{
                        //    Navigator.push(context,MaterialPageRoute(builder: (context)=>Canceldetails(item:widget.item)));
                  await   cancelfood(widget.item.id);
                     } ,
                   ),
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }

   Future<void> cancelfood(String id) async {
    String url = "http://192.168.172.163/hopephp/food/cancelbooking.php";
    var res = await http.post(Uri.parse(url), body: {
      "uid": id,
    });
    print(id);
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      Fluttertoast.showToast(
          msg: 'Food Cancelled',
          backgroundColor: Colors.amber,
          textColor: Colors.white);
      Navigator.pop(context);
    }
  }
}
