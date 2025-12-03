// import 'dart:convert';
// import 'package:hopecart/user/homeuser.dart';
// import 'package:hopecart/user/user%20food/viewbookedfd.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Canceldetails extends StatefulWidget {
//   final Userfoods item;
//   const Canceldetails({super.key, required this.item});

//   @override
//   State<Canceldetails> createState() => _CanceldetailsState();
// }

// class _CanceldetailsState extends State<Canceldetails> {
//   @override
//   Widget build(BuildContext context) {
//     var screensize=MediaQuery.of(context).size.height;
//     return Scaffold(
//         appBar: AppBar( ),
//         body: SingleChildScrollView(
//             child: Center(
//               child: Container(
//                 margin: EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                    CircleAvatar(
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
//                         Icons.remove_shopping_cart,
//                         color: Theme.of(context).colorScheme.secondary,
//                         size: 50,
//                       ),
                      
//                     ],
//                   ),
//                 ),
//                   Row(
//                     children: [
//                       const SizedBox(
//                         width: 50,
//                       ),
//                       Text(
//                         "Name :",
//                         style: GoogleFonts.adamina(
//                             fontSize: 20, color: Colors.green),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Text(widget.item.name,
//                           style: GoogleFonts.taiHeritagePro(
//                               fontSize: 20, color: Colors.green.shade900))
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       const SizedBox(
//                         width: 50,
//                       ),
//                       Text(
//                         "Food Type :",
//                         style: GoogleFonts.adamina(
//                             fontSize: 20, color: Colors.green),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Text(widget.item.foodtype,
//                           style: GoogleFonts.taiHeritagePro(
//                               fontSize: 20, color: Colors.green.shade900))
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       const SizedBox(
//                         width: 50,
//                       ),
//                       Text(
//                         "Date:",
//                         style: GoogleFonts.adamina(
//                             fontSize: 20, color: Colors.green),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(widget.item.date,
//                           style: GoogleFonts.taiHeritagePro(
//                               fontSize: 20, color: Colors.green.shade900))
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             // title: new Text("Alert!!"),
//                             content: Text(
//                               "Are you sure you want to Cancel Food Booking?",
//                               style: TextStyle(
//                                   fontSize: 18, color: Colors.green.shade900),
//                             ),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
                  
//                                   cancelfood(widget.item.id);
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => user_home()));
                  
//                                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>cancel_food()));
//                                 },
//                                 child: const Text('OK',
//                                     style: TextStyle(
//                                         color: Colors.green, fontSize: 15)),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text('CANCEL',
//                                     style: TextStyle(
//                                         color: Colors.green, fontSize: 15)),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green),
//                     child: Text("Cancel Food Booking"),
//                   ),
//                   const SizedBox(
//                     height: 80,
//                   ),
//                   SizedBox(
//                     width: 400,
//                     height: 300,
//                     child: Image.asset('assets/images/food.jpg',
//                         fit: BoxFit.fill),
//                   ),
//                 ]),
//               ),
//             )));
//   }

//   Future<void> cancelfood(String id) async {
//     String url = "http://192.168.172.163/hopephp/food/cancelbooking.php";
//     var res = await http.post(Uri.parse(url), body: {
//       "uid": id,
//     });
//     print(id);
//     var resoponse = jsonDecode(res.body);
//     if (resoponse["success"] == "true") {
//       Fluttertoast.showToast(
//           msg: 'Food Cancelled',
//           backgroundColor: Colors.amber,
//           textColor: Colors.white);
//       Navigator.pop(context);
//     }
//   }
// }
