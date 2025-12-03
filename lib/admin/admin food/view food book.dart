import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hopecart/admin/admin%20food/view%20food%20in%20detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class User_model {
  // final String id;
  final String id;
  final String name;
  final String date;
  final String foodtype;

  User_model({
    // required this.id,
    required this.id,
    required this.name,
    required this.date,
    required this.foodtype,
  });
}

class view_food extends StatefulWidget {
  const view_food({super.key});

  @override
  _view_foodState createState() => _view_foodState();
}

class _view_foodState extends State<view_food> {
//Applying get request.


String? adminKey;
  Future getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = sharedprefs.getString('get_id');
    setState(() {
      adminKey = obtainedemail;
    });
    print('this is service  value $adminKey');
  }
   Future<List<User_model>> getRequest() async {
    try {
      final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
      var ui = sharedprefs.getString('user_id');
      debugPrint('getRequest: shared prefs user_id="$ui"');

      if (ui == null) {
        debugPrint('getRequest: user_id is null in SharedPreferences');
        return [];
      }

      // If running on Android emulator, you might need: 10.0.2.2
      String APIURL = "http://192.168.123.163/hopephp/food/admin_view_food.php";

      Map mapeddate = {
        'id': ui,
      };

      final response = await http.post(Uri.parse(APIURL), body: mapeddate).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        debugPrint('getRequest: HTTP ${response.statusCode} - ${response.reasonPhrase}');
        return [];
      }

      final responseData = jsonDecode(response.body);
      if (responseData is! List) {
        debugPrint('getRequest: unexpected response format: ${response.body}');
        return [];
      }

      List<User_model> users = [];
      for (var singleUser in responseData) {
        users.add(User_model(
          id: singleUser["id"].toString(),
          name: singleUser["name"].toString(),
          date: singleUser["date"].toString(),
          foodtype: singleUser["foodtype"].toString(),
        ));
      }
      return users;
    } catch (e, st) {
      debugPrint('getRequest error: $e\n$st');
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   radius: 60,
                //   child: Stack(
                //     alignment: Alignment(2.8, -3),
                //     children: [
                //       Icon(
                //         Icons.restaurant_menu,
                //         color: Theme.of(context).colorScheme.secondary,
                //         size: 40,
                //       ),
                //       Icon(
                //         Icons.notifications_active_outlined,
                //         color: Theme.of(context).colorScheme.secondary,
                //         size: 23,
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 20),
                //   Text(
                //         " Ordered Meals",
                //         style: GoogleFonts.openSans(
                //           fontSize: 30,
                //           letterSpacing: 1,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       SizedBox(height: 5),
                      // Text(
                      //   "Support a good cause",
                      //   style: GoogleFonts.nunito(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // SizedBox(height: 20),


                FutureBuilder<List<User_model>>(
                  future: getRequest(),
                  builder: (BuildContext ctx, AsyncSnapshot<List<User_model>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.red.shade900,
                              strokeWidth: 5,
                            ),
                            const SizedBox(height: 30),
                            const Text("Data Loading Please Wait!"),
                          ],
                        ),
                      );
                    }
                          
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                          
                    final data = snapshot.data ?? [];
                    if (data.isEmpty) {
                      return Center(child: Text('No records found.'));
                    }
                          
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        final item = data[index];
                        return Column(
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.black,

                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: ListTile(
                                      leading: Container(
                                        height: 55,
                                        width: 50,
                                        // decoration: BoxDecoration(
                                        //   color: Colors.deepOrange,
                                        //   border: Border.all(color: Colors.white),
                                        // ),
                                        child: Icon(Icons.image),
                                      ),
                                       onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Viewfoodindetail(data_user: item),
                                            ),
                                          );
                                        },
                                      textColor: Colors.deepOrange,
                                      title: Text(item.name, style: GoogleFonts.lora()),
                                      subtitle: Text(item.foodtype, style: GoogleFonts.lora()),
                                      trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.deepOrange),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 25),
                                      Text(item.date, style: GoogleFonts.lora(color: Colors.white)),
                                    ],
                                  ),
                                  const SizedBox(height: 5)
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          
          ),
        ),
      ),
    );
  }

  
}


