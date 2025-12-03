import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20event/common%20class.dart';
import 'package:hopecart/admin/admin%20event/editevent.dart';

import 'package:http/http.dart' as http;


//Creating a class user to store the data;
// class View_before_edit {
//   // final String id;
//   final String id;
//   final String name;
//   final String date;
//   final String time;
//   final String description;

//   View_before_edit({
//     // required this.id,
//     required this.id,
//     required this.name,
//     required this.date,
//     required this.time,
//     required this.description,
//   });
// }

class admin_edit_event extends StatefulWidget {
  const admin_edit_event({super.key});

  @override
  _admin_edit_eventState createState() => _admin_edit_eventState();
}

class _admin_edit_eventState extends State<admin_edit_event> {
//Applying get request.

  Future<List<Eventclass>> getRequest() async {
    //replace your restFull API here.
    String url = "http://192.168.123.163/hopephp/event/view_event.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Eventclass> users = [];
    for (var singleUser in responseData) {
      Eventclass user = Eventclass(
        //id:  singleUser["id"].toString(),
        id: singleUser["Uid"].toString(),
        name: singleUser["name"].toString(),
        date: singleUser["date"].toString(),
        time: singleUser["time"].toString(),
        description: singleUser["description"].toString(),
      );
      print("the uid is ${user.id}");

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Stack(
                      alignment: Alignment(2.8, 2.2),
                      children: [
                        Icon(
                          Icons.event,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 40,
                        ),
                        Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 23,
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(height: 5),
          
                  Text(
                    " Select to edit",
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
                    ),
                  ),
                  const SizedBox(height: 20),
                FutureBuilder(
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
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
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
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 15),
                                      child: ListTile(
                                        onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          edit_event(
                                                            edit:
                                                                snapshot.data[index],
                                                          )));
                                            },
                                        textColor: Colors.deepOrange,
                                        leading:Container(
                                        height: 55,
                                        width: 50,
                                        // decoration: BoxDecoration(
                                        //   color: Colors.deepOrange,
                                        //   border: Border.all(color: Colors.white),
                                        // ),
                                        child: Icon(Icons.image),
                                      ),
                                        title: Text(
                                          snapshot.data[index].name,
                                        ),
                                        subtitle: Text(
                                          snapshot.data[index].date,
                                        ),
                                        trailing: Icon(
                                          Icons.edit,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              snapshot.data[index].time,
                                              style: TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                     
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                           
                          ],
                        ),
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
