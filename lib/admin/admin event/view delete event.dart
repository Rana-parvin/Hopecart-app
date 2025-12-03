import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20event/common%20class.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hopecart/admin/admin%20event/deleteevent.dart';

class Deleteevent extends StatefulWidget {
  const Deleteevent({super.key});

  @override
  State
  <Deleteevent> createState() => _DeleteeventState();
}

// class View_before_delete {
//   // final String id;
//   final String id;
//   final String name;
//   final String date;
//   final String time;
//   final String description;

//   View_before_delete({
//     // required this.id,
//     required this.id,
//     required this.name,
//     required this.date,
//     required this.time,
//     required this.description,
//   });
// }

class _DeleteeventState extends State<Deleteevent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: Scaffold(
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
                    alignment: Alignment(2.8, -2.5),
                    children: [
                      Icon(
                        Icons.event,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 40,
                      ),
                      Icon(
                        Icons.description,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 23,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                 Text(
                  " Events",
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
                    future: vieweventstodelete(),
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
                                          textColor: Colors.deepOrange,
                                          title: Text(
                                            snapshot.data[index].name,
                                          ),
                                         
                                                      
                                          subtitle: Text(
                                            snapshot.data[index].date,
                                          ),
                                          onTap: ()
                                          {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>event_dt(deleteit: snapshot.data[index],)));
    
                                          },
                                          trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.deepOrange,),
                                                      
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width:50 ,),
                                              Text(  snapshot.data[index].time,style: TextStyle(color: Colors.white),)
                                            ],
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
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
      ),  
        );
  }

  Future<List<Eventclass>> vieweventstodelete() async {
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
      

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }
}