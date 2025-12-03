import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20event/common%20class.dart';
import 'package:hopecart/admin/admin%20event/editevent.dart';
import 'package:hopecart/admin/admin%20event/view%20event_details.dart';
import 'package:http/http.dart' as http;

//Creating a class user to store the data;
// class Events_in_detail {
//   // final String id;
//   final String id;
//   final String name;
//   final String date;
//   final String time;
//   final String description;

//   Events_in_detail({
//     // required this.id,
//     required this.id,
//     required this.name,
//     required this.date,
//     required this.time,
//     required this.description,
//   });

//  // void add(List<Events_in_detail> users) {}
// }

class view_events extends StatefulWidget {
  //  final Eventclass data;

  const view_events({super.key});

  @override
  _view_eventsState createState() => _view_eventsState();
}

class _view_eventsState extends State<view_events> {
  Future<List<Eventclass>> viewallevents() async {
    String url = "http://192.168.123.163/hopephp/event/view_event.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    List<Eventclass> users = [];
    for (var singleUser in responseData) {
      Eventclass user = Eventclass(
        id: singleUser["Uid"].toString(),
        name: singleUser["name"].toString(),
        date: singleUser["date"].toString(),
        time: singleUser["time"].toString(),
        description: singleUser["description"].toString(),
      );
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              children: [
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   radius: 60,
                //   child: Stack(
                //     alignment: Alignment(2.8, -2.5),
                //     children: [
                //       Icon(
                //         Icons.event,
                //         color: Theme.of(context).colorScheme.secondary,
                //         size: 40,
                //       ),
                //       Icon(
                //         Icons.description,
                //         color: Theme.of(context).colorScheme.secondary,
                //         size: 23,
                //       ),
                //     ],
                //   ),
                // ),
               // const SizedBox(height: 5),

                // Text(
                //   " Events",
                //   style: GoogleFonts.openSans(
                //     fontSize: 30,
                //     letterSpacing: 1,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
            //    const SizedBox(height: 5),
                // Text(
                //   "Support a good cause",
                //   style: GoogleFonts.nunito(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // const SizedBox(height: 20),
                FutureBuilder(
                  future: viewallevents(),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.black,
                            
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => a_event_details(
                                              events: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      leading: Container(
                                        height: 55,
                                        width: 50,
                                        // decoration: BoxDecoration(
                                        //   color: Colors.deepOrange,
                                        //   border: Border.all(color: Colors.white),
                                        // ),
                                        child: Icon(Icons.image),
                                      ),
                                      textColor: Colors.black,
                                      title: Text(
                                        snapshot.data[index].name,
                                        style: GoogleFonts.kiteOne(fontSize: 14),
                                      ),
                            
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            snapshot.data[index].date,
                                            style: GoogleFonts.farro(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].time,
                                            style: GoogleFonts.cabin(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      edit_event(
                                                        edit:
                                                            snapshot.data[index],
                                                      ),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                            
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) =>
                                                    AlertDialog(
                                                      title: const Text(
                                                        'Delete item',style: TextStyle(color: Color(0xFFE17453)),
                                                      ),
                                                      content: const Text(
                                                        "Are you sure you want to delete this event?",
                                                        style: TextStyle(color: Color(0xFFE17453),fontWeight: FontWeight.bold),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[700],
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await cancel_event(
                                                              snapshot
                                                                  .data[index].id
                                                                  ,
                                                            );
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Text(
                                                            "Sure",
                                                            style: TextStyle(
                                                              color: Color(0xFFE17453),fontWeight: FontWeight.w600
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              );
                                            },
                                            icon: Icon(Icons.delete_rounded),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      //    const SizedBox(height: 20),
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

  Future<void> cancel_event(String id) async {
    String url = "http://192.168.123.163/hopephp/event/deleteevent.php";
    try {
      // Send the id in the request body
      var res = await http.post(
        Uri.parse(url),
        body: {
          "id": id, // Ensure 'id' is sent in the body
        },
      );

      // Decode the response from PHP
      var response = jsonDecode(res.body);
      print("Response: $response"); // Print the response for debugging
      if (response["success"] == "Successfully Deleted") {
        print("Event successfully cancelled.");
        Fluttertoast.showToast(
          msg: 'Selected event deleted Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
        );
      } else {
        print("Failed to cancel event.");
        Fluttertoast.showToast(
          msg: 'Failed to cancel the event',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
