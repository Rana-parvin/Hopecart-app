import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/single%20class.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'viewcraftdetails.dart';

//Creating a class user to store the data;
// class All_events {
//   final String id;
//   final String craftid;
//   final String name;
//   final String price;
//   final String description;
//   final String image;

//   All_events({
//     required this.id,
//     required this.craftid,
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.image,
//   });
// }

class view_craft extends StatefulWidget {
  const view_craft({super.key});

  @override
  _view_craftState createState() => _view_craftState();
}

class _view_craftState extends State<view_craft> {
  //Applying get request.

  Future<List<craftclass>> getRequest() async {
    //replace your restFull API here.
    String url = "http://192.168.39.163/hopephp/craft/viewcraft.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<craftclass> users = [];
    for (var singleUser in responseData) {
      craftclass user = craftclass(
        id: singleUser["id"].toString(),
        craftid: singleUser["craftid"].toString(),
        name: singleUser["name"].toString(),
        price: singleUser["price"].toString(),
        description: singleUser["description"].toString(),
        image: singleUser["image"].toString(),
      );

      //Adding user to the list.1
      users.add(user);
    }
    return users;
  }

  late Future<bool> islogged;
  @override
  void initState() {
    super.initState();
    islogged = checklogged();
  }

  Future<bool> checklogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id') != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     FutureBuilder<bool>(
      //       future: islogged,
      //       builder: (context, snap) {
      //         final logged = snap.data ?? false;
      //         if (logged) {
      //           return IconButton(
      //             icon: const Icon(Icons.logout),
      //             onPressed: () async {
      //               final prefs = await SharedPreferences.getInstance();
      //               await prefs.remove('user_id');
      //               setState(() => islogged = Future.value(false));
      //             },
      //           );
      //         } else {
      //           return TextButton(
      //             onPressed: () {
      //               // navigate to login page
      //               Navigator.pushNamed(context, '/adminLogin');
      //             },
      //             child: const Text(
      //               'Sign In',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //           );
      //         }
      //       },
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              //  CircleAvatar(
              //     backgroundColor: Colors.white,
              //     radius: 60,
              //     child: Stack(
              //       alignment: Alignment(2.2, 1),
              //       children: [
              //         Icon(
              //           Icons.brush,
              //           color: Theme.of(context).colorScheme.secondary,
              //           size: 27,
              //         ),
                     
              //          Icon(
              //           Icons.color_lens,
              //           color: Theme.of(context).colorScheme.secondary,
              //           size: 50,
              //         ),
                      
              //       ],
              //     ),
              //   ),
                //  Text(
                //   " Craft Items",
                //   style: GoogleFonts.openSans(
                //     fontSize: 30,
                //     letterSpacing: 1,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // SizedBox(height: 5),
                // Text(
                //   "Support a good cause",
                //   style: GoogleFonts.nunito(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //     letterSpacing: 1,
                //   ),
                // ),
                // SizedBox(height: 20),
              FutureBuilder<List<craftclass>>(
                future: getRequest(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text('Loading...'),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load: ${snapshot.error}'),
                    );
                  }

                  final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return const Center(child: Text('No records found.'));
                  }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                                
                            child: SizedBox(
                              
                              child: ListTile(
                                contentPadding: EdgeInsets.all(
                                  15.0,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    color: Colors.deepOrange,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(snapshot.data[index].image)
                                    ),
                                  ),
                                ),
                                
                                title: Text(
                                  "${snapshot.data[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lora(
                                    fontSize: 15,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                subtitle: Text(
                                      "price: ${snapshot.data[index].price}",
                                      overflow:
                                          TextOverflow.ellipsis,
                                      style: GoogleFonts.lora(
                                        fontSize: 15,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                               trailing: TextButton.icon(
                                 onPressed: () {
                                   Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) =>
                                           a_craft_details(
                                             craft: snapshot
                                                 .data[index],
                                           ),
                                     ),
                                   );
                                 },label: Text("Details",style: TextStyle(color: Colors.black),),
                                 icon: Icon(
                                   Icons
                                       .arrow_forward_ios_rounded,
                                   color: Colors
                                       .lightGreenAccent
                                       .shade100,
                                 ),
                                 iconAlignment: IconAlignment.end,
                               ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
               //   }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
