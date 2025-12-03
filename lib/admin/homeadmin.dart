import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hopecart/admin/admin%20food/view%20food%20book.dart';
import 'package:hopecart/admin/admin%20order/admin%20view%20order.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20craft/edit%20craftview.dart';
import 'package:hopecart/admin/admin%20donation/admin_view_donation.dart';
import 'package:hopecart/admin/admin%20event/addevent.dart';
import 'package:hopecart/admin/admin%20event/view%20edit.dart';
import 'package:hopecart/admin/admin%20event/view%20delete%20event.dart';
import 'package:hopecart/admin/admin%20event/view_event.dart';
import 'package:hopecart/admin/admin%20craft/viewcraft.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Data_model {
  // final String id;
  final String id;
  final String name;
  final String date;
  final String foodtype;

  Data_model({
    // required this.id,
    required this.id,
    required this.name,
    required this.date,
    required this.foodtype,
  });
}

class admin_home extends StatefulWidget {
  const admin_home({super.key});

  @override
  _admin_homeState createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: admindrawer(),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
             CircleAvatar(
                        radius: 50,backgroundColor:const Color(0xFFFFFFFF),
                        child: Stack(alignment: Alignment(1, -1.1),
                          children: [
                            Icon(Icons.home_rounded,size: 60,color:  const Color(0xFFF47C2C),),
                            Icon(Icons.favorite,size: 20,color:  const Color(0xFFF47C2C),)
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
            SizedBox(
              height: 30,
              width: 300,
              child: Center(
                child: Text(
                  "Welcome Admin",
                  style: GoogleFonts.aclonica(
                    fontSize: 25,
                    color: Color(0xFFF47C2C),
                  ),
                ),
              ),
            ),
             SizedBox(height: 10,),
            Text("Which section do you wanna manage",style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
        
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Options(
                  name: "Events",
                  ontap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => view_events()),
                    );
                  },
                ),

                          
            Options(name: "crafts", ontap: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => view_craft()),
                );
            }),
              ],
            ),
        
                  
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Options(name: "Donations", ontap: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Adminviewdonation()),
                    );
                }),
                  Options(name: "Meals", ontap: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => view_food()),
                );
            }),
              ],
            ),
                  
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: GridView.count(
          //     shrinkWrap: true,
          //   //  physics: const NeverScrollableScrollPhysics(),
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 20,
          //     crossAxisSpacing: 20,
          //     physics: NeverScrollableScrollPhysics(),
          //   childAspectRatio: 1,
          //     children: [
          //       Options(
          //         name: "Events",
          //         ontap: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (c) => view_events()));
          //         },
          //       ),
          //       Options(
          //        name: "Crafts",
          //         ontap: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (c) => view_craft()));
          //         },
          //      ),
          //       Options(
          //         name: "Donations",
          //         ontap: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (c) => Adminviewdonation()));
          //         },
          //       ),
          //       Options(
          //         name: "Meals",
          //         ontap: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (c) => view_food()));
          //         },
          //      ),
          //     ],
          //                ),
          // ),

        
        
          ],
        ),
      ),
    );
  }
}

class admindrawer extends StatelessWidget {
  const admindrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: const Color(0xFFF47C2C)),
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
          drawercontainer(
            title: 'Add event',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const add_events()),
              );
            },
          ),
        //  const SizedBox(height: 10),
          drawercontainer(
            title: "view events",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => view_events()),
              );
            },
          ),
        //  const SizedBox(height: 10),
          drawercontainer(
            title: "Edit event",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => admin_edit_event()),
              );
            },
          ),
         // const SizedBox(height: 10),
          drawercontainer(
            title: "Delete event",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Deleteevent()),
              );
            },
          ),
        //  const SizedBox(height: 10),
          drawercontainer(
            title: "View donations",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Adminviewdonation()),
              );
            },
          ),
        //  const SizedBox(height: 10),
          drawercontainer(
            title: "View meals",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => view_food()),
              ); //viewfood
            },
          ),
        //  const SizedBox(height: 10),
          drawercontainer(
            title: "edit craft view",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => edit_craft_view()),
              );
            },
          ),
         // const SizedBox(height: 10),
          drawercontainer(
            title: "Add craft",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Addcraft()),
              );
            },
          ),
        //  const SizedBox(height: 10),
          drawercontainer(
            title: 'Orders',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Adminvieworder()),
              );
            },
          ),
        ],
      ),
    );
  }
  Future<List<Data_model>> getRequest() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var uid = sharedprefs.getString('user_id');
    //replace your restFull API here.
    String APIURL = "http://192.168.172.163/hopephp/food/foodbooking.php";

    Map mapeddate = {'id': uid.toString()};
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: mapeddate);

    var responseData = jsonDecode(reponse.body);

    //Creating a list to store input data;
    List<Data_model> users = [];
    for (var singleUser in responseData) {
      Data_model user = Data_model(
        //id:  singleUser["id"].toString(),
        id: singleUser["id"].toString(),
        name: singleUser["name"].toString(),
        date: singleUser["date"].toString(),
        foodtype: singleUser["foodtype"].toString(),
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }
}

class drawercontainer extends StatelessWidget {
  final String title;
  final GestureTapCallback ontap;
  const drawercontainer({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: const Color(0xFFF47C2C),
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          onTap: ontap,
        ),
      ),
    );
  }
}

class Options extends StatefulWidget {
  final void Function()? ontap;
  final String name;
  const Options({super.key, required this.name, required this.ontap});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        focusColor: Colors.grey,
        onTap: widget.ontap,
        child: ClipRRect(
          child: Container(height: 150,width: 150,
            decoration: BoxDecoration(
              
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(alignment: Alignment.center,
              child: Text(
                widget.name,
                style: GoogleFonts.aclonica(fontSize: 18,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
