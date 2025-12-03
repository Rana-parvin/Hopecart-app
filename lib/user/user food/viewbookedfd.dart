import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hopecart/user/user%20food/food%20details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class Userfoods {
  // final String id;
  final String id;
  final String name;
  final String date;
  final String foodtype;

  Userfoods({
    // required this.id,
    required this.id,
    required this.name,
    required this.date,
    required this.foodtype,
  });
}


class Viewbookedfd extends StatefulWidget {
  const Viewbookedfd({super.key});

  @override
  State<Viewbookedfd> createState() => _ViewbookedfdState();
}

class _ViewbookedfdState extends State<Viewbookedfd> {

  String? userKey;
  @override
  Widget build(BuildContext context) {
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
                  " Ordered Meals ",
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
                SizedBox(height: 20),
                   FutureBuilder(future:getRequest() , builder:(BuildContext ctx,AsyncSnapshot snapshot){
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
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) => Column(
                            children: [
                              Padding(
                              padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,       ),
                              child: Card(
                                  color: Colors.white,
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                                                   
                                  child: Column(
                                    children: [
                                                   
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: ListTile(
                                           onTap: (){
                                                   
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Fooddetails(item: snapshot.data[index],)));
                                                   
                                              },
                                          title: Text(
                                            snapshot.data[index].name,
                                            style: GoogleFonts.lora(),
                                          ),
                                          
                                          subtitle: Text(
                                            snapshot.data[index].foodtype,
                                              style: GoogleFonts.lora(),
                                          ),
                                          trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                                                   
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(width:25 ,),
                                              Text(  snapshot.data[index].date,style: GoogleFonts.lora(),)
                                            ],
                                          ),
                                          const SizedBox(height: 5,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      
                   } ),
                 ],
               ),
            ),
          ),
        ),
    );
  }
  Future getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = sharedprefs.getString('user_id');
    setState(() {
      userKey = obtainedemail;
    });
    print('thisis service  value $userKey');
  }
  Future<List<Userfoods>> getRequest() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var ui = sharedprefs.getString('user_id');
    //replace your restFull API here.
    String APIURL = "http://192.168.172.163/hopephp/food/viewbookedfd.php?uid=${ui!}";

    Map mapeddate = {
      'id': userKey.toString(),
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: mapeddate);

    var responseData =jsonDecode(reponse.body);

    //Creating a list to store input data;
    List<Userfoods> users = [];
    for (var singleUser in responseData) {
      Userfoods user = Userfoods(
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