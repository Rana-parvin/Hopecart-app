import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20meal/meal%20class.dart';
import 'package:hopecart/admin/admin%20meal/meal%20details.dart';
import 'package:http/http.dart' as http;

class Viewitems extends StatefulWidget {
  final bool showappbar;
  const Viewitems({super.key, required this.showappbar});

  @override
  State<Viewitems> createState() => _ViewitemsState();
}

class _ViewitemsState extends State<Viewitems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.showappbar  ?  AppBar(
        title:Text(
          "Craft Items",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
      //  backgroundColor: Colors.deepOrange,
        elevation: 0,
        ) : null,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: FutureBuilder<List<Mealclass>>(
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
                        borderRadius: BorderRadius.circular(10),
                      ),
          
                      child: SizedBox(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Mealdetails(meal: snapshot.data[index]),
                              ),
                            );
                          },
                          contentPadding: EdgeInsets.all(15.0),
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              color: Colors.deepOrange,
                              border: Border.all(color: Colors.white),
                              // image: DecorationImage(
                              //   fit: BoxFit.cover,
                              //   image: AssetImage('assets/images/craft1.avif')
                              // ),
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
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lora(
                              fontSize: 15,
                              color: Colors.deepOrange,
                            ),
                          ),
                          trailing: TextButton.icon(
                            onPressed: () {},
                            label: Text(
                              "Details",
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.lightGreenAccent.shade100,
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
        ),
      ),
    );
  }

  Future<List<Mealclass>> getRequest() async {
    //replace your restFull API here.
    String url = "http://192.168.172.163/hopephp/meal/listofmeals.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Mealclass> users = [];
    for (var singleUser in responseData) {
      Mealclass user = Mealclass(
        mealid: singleUser["mealid"].toString(),
        size: singleUser["size"].toString(),
        name: singleUser["name"].toString(),
        price: singleUser["price"].toString(),
        description: singleUser["description"].toString(),
        image: singleUser["image"].toString(),
        ingredients: singleUser["ingredients"].toString(),
      );

      //Adding user to the list.1
      users.add(user);
    }
    return users;
  }
}
