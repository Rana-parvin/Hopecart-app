import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20event/common%20class.dart';
import 'package:hopecart/admin/admin%20event/view%20delete%20event.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class event_dt extends StatefulWidget {
  final Eventclass deleteit;

  const event_dt({super.key, required this.deleteit});

  @override
  _event_dtState createState() => _event_dtState();
}

class _event_dtState extends State<event_dt> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenheight=MediaQuery.of(context).size.height;
        var screenwidth=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
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
                          Icons.delete,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 23,
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(height: 20),
                   Text(
                          " Delete this Event",
                          style: GoogleFonts.openSans(
                            fontSize: 30,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    const    SizedBox(height: 5),
                        Text(
                          "Support a good cause",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  const    SizedBox(height: 20),
          
          
                     Center(
                          child: Text(widget.deleteit.name, style: GoogleFonts.taiHeritagePro(
                               fontSize: 25, color: Colors.black)),
                        ),
                        const SizedBox(height: 20,),
                   Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 15,
                          bottom: 7,
                        ),
                        child: Container(
                                height: screenheight * 0.2,
                            width: screenwidth * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 15,
                          bottom: 7,
                        ),
                        child: Text(
                          "Description:",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 15,
                          top: 7,
                        ),
                        child: Text("${widget.deleteit.description}"),
                      ),
                    ],
                  ),
                                  ),),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                    children: [
                      Text("Due date:",
                        style: GoogleFonts.adamina(fontSize: 20, color: Colors.black),),
                      SizedBox(width: 10,),
                      Text(widget.deleteit.date, style: GoogleFonts.taiHeritagePro(
                          fontSize: 20, color: Colors.black))
                    ], 
                    ),
               ),
                   const  SizedBox(height:5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    children: [
                      Text("On:",
                        style: GoogleFonts.adamina(fontSize: 20, color: Colors.black),),
                      SizedBox(width: 10,),
                      Text(widget.deleteit.time, style: GoogleFonts.taiHeritagePro(
                          fontSize: 20, color: Colors.black))
                    ],
                      ),
              ),
                  const SizedBox(height: 20,),
              formbutton(text: "Remove Event",
                  height: screenheight / 20,
                  width: screenwidth / 1.5,                  
                  onpressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert!!"),
                          content: Text(
                            "Are you sure to Cancel this Event?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green.shade900,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                final success = await cancel_event(
                                  widget.deleteit.id,
                                );
                                if (success) {
                                  Fluttertoast.showToast(
                                    msg: 'Event Cancelled',
                                    backgroundColor: Colors.amber,
                                    textColor: Colors.white,
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Deleteevent(),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                     );
                    },            )
                  
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildlabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 2),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildvalue(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 45, bottom: 15),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Future<bool> cancel_event(String id) async {
const url = "http://192.168.131.163/hopephp/event/deleteevent.php";
    debugPrint('cancel_event: id=$id');

    try {
      // Send the id in the request body
      final response = await http.post(
        Uri.parse(url),
        body: {
          "id": id, // Ensure 'id' is sent in the body
        },
      ).timeout(const Duration(seconds: 30));
            debugPrint('cancel_event: status=${response.statusCode} body=${response.body}');

      if (response.statusCode != 200) {
        Fluttertoast.showToast(
          msg: 'Server error (${response.statusCode})',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }
      try {
        final data = jsonDecode(response.body);
        if (data['success'] == 'Successfully Deleted') {
          debugPrint('cancel_event: success');
          return true;
        } else {
          final msg = data['message'] ?? 'Failed to delete';
          Fluttertoast.showToast(
            msg: msg,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          return false;
        }
      } on FormatException {
        debugPrint('cancel_event: invalid JSON response');
        Fluttertoast.showToast(
          msg: 'Invalid server response',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }

    }  on TimeoutException catch (_) {
      debugPrint('cancel_event: timeout');
      Fluttertoast.showToast(
        msg: 'Request timed out',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    } on SocketException catch (_) {
      debugPrint('cancel_event: network error');
      Fluttertoast.showToast(
        msg: 'Network unreachable',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    } catch (e, st) {
      debugPrint('cancel_event: error: $e\n$st');
      Fluttertoast.showToast(
        msg: 'Unexpected error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
  }
}
