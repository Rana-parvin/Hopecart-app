import 'dart:convert';

import 'package:hopecart/user/user%20event/userviewevent.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hopecart/user/user%20event/deleteeventview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


class cancel_event extends StatefulWidget {


  final Userevents data_user;

  const cancel_event({super.key, required this.data_user});
  // const craft_details({Key? key}) : super(key: key);

  @override
  _cancel_eventState createState() => _cancel_eventState();
}

class _cancel_eventState extends State<cancel_event> {


  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 30,),
                        Text("Name:",
                          style: GoogleFonts.adamina(fontSize: 20, color: Colors.green),),
                        SizedBox(width: 20,),
                        Text(widget.data_user.name, style: GoogleFonts.taiHeritagePro(
                            fontSize: 20, color: Colors.green.shade900))
                      ],

                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 30,),
                        Text("Description:",
                          style: GoogleFonts.adamina(fontSize: 20, color: Colors.green),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 30,),
                        Expanded(
                          child: Text(widget.data_user.description,
                            style: GoogleFonts.taiHeritagePro(
                                fontSize: 20, color: Colors.green.shade900),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 50,),
                        )
                      ],

                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 30,),
                        Text("Date:",
                          style: GoogleFonts.adamina(fontSize: 20, color: Colors.green),),
                        SizedBox(width: 10,),
                        Text(widget.data_user.date, style: GoogleFonts.taiHeritagePro(
                            fontSize: 20, color: Colors.green.shade900))
                      ],

                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 30,),
                        Text("Time:",
                          style: GoogleFonts.adamina(fontSize: 20, color: Colors.green),),
                        SizedBox(width: 10,),
                        Text(widget.data_user.time, style: GoogleFonts.taiHeritagePro(
                            fontSize: 20, color: Colors.green.shade900))
                      ],

                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // title: new Text("Alert!!"),
                            content: Text("Are you sure to Cancel this Event?",style: TextStyle(fontSize:18,color: Colors.green.shade900),),
                            actions: <Widget>[

                              TextButton(onPressed: (){
                                cancel_event(widget.data_user.id);

                                Fluttertoast.showToast(
                                    msg: 'Event Cancelled',
                                    // toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.amber,
                                    textColor: Colors.white
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>deleteeventviews()));
                              }, child: Text('OK',style: TextStyle(color: Colors.green,fontSize: 15)),),

                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('CANCEL',style: TextStyle(color: Colors.green,fontSize: 15)),),
                            ],
                          );
                        },
                      );

                    },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green
                      ), child: Text("Cancel Event"),)
                  ],
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: 600,
                height:250,
                child: Image.asset('assets/images/e1.avif', fit: BoxFit.fill),

              )
            ],
          ),
        )
    );
  }
  Future<void> cancel_event(String id) async {
    String url =
        "http://192.168.39.163/hopephp/event/deleteevent.php";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }

}

