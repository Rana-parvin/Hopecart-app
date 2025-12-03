// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:hopecart/user/user%20food/canceldetails.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hopecart/user/user%20food/viewbookedfd.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:hopecart/user/usersplash.dart';


// // class User_model {
// //   final String id;
// //   final String name;
// //   final String date;
// //   final String foodtype;

// //   User_model({
// //     required this.id,
// //     required this.name,
// //     required this.date,
// //     required this.foodtype,
// //   });
// // }

// class Cancelbooking extends StatefulWidget {
//   const Cancelbooking({super.key});

//   @override
//   State<Cancelbooking> createState() => _CancelbookingState();
// }

// class _CancelbookingState extends State<Cancelbooking> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//            body: SingleChildScrollView(
//           child: Center(
//             child: Container(
//               margin: EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                     CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 60,
//                   child: Stack(
//                     alignment: Alignment(0, -2.5),
//                     children: [
//                       Icon(
//                         Icons.local_restaurant_sharp,
//                         color: Theme.of(context).colorScheme.secondary,
//                         size: 27,
//                       ),
                     
//                        Icon(
//                         Icons.shopping_cart,
//                         color: Theme.of(context).colorScheme.secondary,
//                         size: 50,
//                       ),
                      
//                     ],
//                   ),
//                 ),
//                   FutureBuilder(
//                     future: getRequest(),
//                     builder: (BuildContext ctx, AsyncSnapshot snapshot) {
//                      if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const [
//                               CircularProgressIndicator(),
//                               SizedBox(height: 12),
//                               Text('Loading...'),
//                             ],
//                           ),
//                         );
//                       }
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text('Failed to load: ${snapshot.error}'),
//                         );
//                       }
                  
//                       final items = snapshot.data ?? [];
//                       if (items.isEmpty) {
//                         return const Center(child: Text('No records found.'));
//                       }
                      
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: snapshot.data.length,
//                           itemBuilder: (ctx, index) => Column(
//                             children: [
//                               Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                   BorderRadius.circular(20),
                                
//                                 ),
//                                 color: Colors.white,
//                                 elevation: 10,
//                                 shadowColor: Colors.black,
                              
//                                 child: Column(
//                                   children: [
                              
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                                       child: ListTile(
//                                      onTap: (){
//                                             Navigator.pushReplacement(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>  Canceldetails(item: snapshot.data[index],)));
                              
//                                             },
//                                         title: Text(
//                                           snapshot.data[index].name,
//                                           style: GoogleFonts.lora(),
//                                         ),
                                       
                              
//                                         subtitle: Text(
//                                           snapshot.data[index].foodtype,
//                                           style: GoogleFonts.lora(),
//                                         ),
//                                         trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.lightGreenAccent.shade100,),
                              
//                                       ),
//                                     ),
//                                     Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const SizedBox(width:25 ,),
//                                             Text(  snapshot.data[index].date,style: GoogleFonts.lora(color: Colors.white),)
//                                           ],
//                                         ),
//                                         const SizedBox(height: 5,)
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                             ],
//                           ),
//                         );
                      
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }

//   Future getValidationData() async {
//     final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
//     var obtainedemail = sharedprefs.getString('user_id');
//     setState(() {
//       userKey = obtainedemail;
//     });
//     print('thisis service  value $userKey');
//   }

//   Future<List<Userfoods>> getRequest() async {
//     final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
//     var uid = sharedprefs.getString('user_id');
//     String APIURL = "http://192.168.172.163/hopephp/food/viewbookedfd.php?uid=${uid!}";

//     Map mapeddate = {
//       'id': userKey.toString(),
//     };
//     http.Response reponse = await http.post(Uri.parse(APIURL), body: mapeddate);

//     var responseData = jsonDecode(reponse.body);

//     List<Userfoods> users = [];
//     for (var singleUser in responseData) {
//       Userfoods user = Userfoods(
//         id: singleUser["id"].toString(),
//         name: singleUser["name"].toString(),
//         date: singleUser["date"].toString(),
//         foodtype: singleUser["foodtype"].toString(),
//       );

//       users.add(user);
//     }
//     return users;
//   }
// }
