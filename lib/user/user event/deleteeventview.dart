import 'dart:convert';
import 'package:hopecart/user/user%20event/userviewevent.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hopecart/user/user%20event/deleteevent.dart';

// class User_model {
//   // final String id;
//   final String id;
//   final String name;
//   final String date;
//   final String time;
//   final String description;

//   User_model({
//     // required this.id,
//     required this.id,
//     required this.name,
//     required this.date,
//     required this.time,
//     required this.description,
//   });
// }

class deleteeventviews extends StatefulWidget {
  const deleteeventviews({super.key});

  @override
  State<deleteeventviews> createState() => _deleteeventviewsState();
}

class _deleteeventviewsState extends State<deleteeventviews> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: Scaffold(
        body: Container(
          
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.red.shade900,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Data Loading Please Wait!",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      Card(
                        color: Colors.green.shade800,
                        elevation: 20,
                        shadowColor: Colors.black,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
    
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: ListTile(
                                textColor: Colors.white,
                                title: Text(
                                  snapshot.data[index].name,
                                ),
                               
    
                                subtitle: Text(
                                  snapshot.data[index].date,
                                ),
                                onTap: ()
                                {
                                 
                                },
                                trailing: GestureDetector(
                                    onTap: (){
                                      
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>cancel_event(data_user: snapshot.data[index],)));
    
                                    },
                                    child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.lightGreenAccent.shade100,)),
    
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
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),  
        );
  }

  Future<List<Userevents>> getRequest() async {
    String url = "http://192.168.39.163/hopephp/event/view_event.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    
    List<Userevents> users = [];

    for (var singleUser in responseData) {
      Userevents user = Userevents(
       
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