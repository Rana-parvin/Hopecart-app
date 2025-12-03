import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20event/common%20class.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/customfield1.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:hope/view_events.dart';

class edit_event extends StatefulWidget {
  final Eventclass edit;

  const edit_event({super.key, required this.edit});

  @override
  _edit_eventState createState() => _edit_eventState();
}

class _edit_eventState extends State<edit_event> {
  TextEditingController _name = TextEditingController();

  TextEditingController _date = TextEditingController();

  TextEditingController _time = TextEditingController();

  TextEditingController _description = TextEditingController();

  late bool status;

  late String message;

  @override
  void initState() {
    _name = TextEditingController(text: widget.edit.name);
    _date = TextEditingController(text: widget.edit.date);
    _time = TextEditingController(text: widget.edit.time);
    _description = TextEditingController(text: widget.edit.description);

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(             
           margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                     CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Stack(
                      alignment: Alignment(2.8, 2.5),
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
                    const      SizedBox(height: 5),
                      
                    Text(
                          " Modify Details",
                          style: GoogleFonts.openSans(
                            fontSize: 30,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const   SizedBox(height: 5),
                        Text(
                          "Support a good cause",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                     const SizedBox(height: 20,),
                    Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15),
                      child: customfield(hinttext: "Event name", controller: _name,
                       prefixicon: Icon(Icons.edit),
                                         validator: (value) {
                          if (value==null || value.isEmpty) {
                            return "Please give a new event title";
                          }
                          return null;
                        }, 
                         obscuretext: false),
                    ),
                    customfield1(
                        prefixicon: Icon(
                          Icons.calendar_month_sharp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        ontap: () async {
                          DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2028),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface:
                                        Colors.deepOrange, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.white, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          String formattedDate = DateFormat(
                            'yyyy-MM-dd',
                          ).format(pickeddate!);
                          setState(() {
                            _date.text = formattedDate;
                            //set output date to TextField value.
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please choose a date";
                          }
                          return null;
                        },
                        controller: _date,
                        hinttext: "Date",
                        borderRadius: BorderRadius.circular(10),                    
                      ), 
                   customfield1(
                        prefixicon: Icon(
                          Icons.timer,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please choose a time";
                          }
                          return null;
                        },
                        controller: _time,
                        hinttext: "Time",
                        borderRadius: BorderRadius.circular(10),
                        //   name: name,
                        ontap: () async {
                          var pickedtime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Theme.of(
                                      context,
                                    ).colorScheme.secondary, // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: const Color.fromARGB(255,247,159,101,), // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.white, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                
                          if (pickedtime != null) {
                            setState(() {
                              _time.text = pickedtime.format(context);
                            });
                          }
                        },
                      ),
                    Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15),
                      child: customfield(hinttext: "Description",
                       controller: _description,
                        prefixicon: Icon(Icons.description),
                        validator: (value) {
                          if ( value==null|| value.isEmpty) {
                            return "Please modify your description";
                          }
                          return null;
                        },                       
                         obscuretext: false
                         ),
                    ),
                    SizedBox(height: 30),
                    formbutton(  height:screenheight/ 17,
                      width: screenwidth / 1.1,
                     text: "Update", 
                      onpressed: () async{
                          if (formkey.currentState!.validate()) {
                           
                           await   Update_event();
                          
                          }
                        },
                      ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future Update_event() async {
    var url = "http://192.168.123.163/hopephp/event/editevent.php";
    //json maping user entered details

    Map mappeddata = {
      'id': widget.edit.id.toString(),
      'name': _name.text.trim(),
      'date': _date.text.trim(),
      'time': _time.text.trim(),
      'description': _description.text.trim(),
    };

    debugPrint('Update_event: sending $mappeddata');
    try{
    //send  data using http post to our php code
    final response = await http
          .post(Uri.parse(url), body: mappeddata)
          .timeout(const Duration(seconds: 15));

      debugPrint('Update_event: status=${response.statusCode} body=${response.body}');

      if (response.statusCode != 200) {
        Fluttertoast.showToast(
          msg: 'Server error (${response.statusCode})',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
        );
        return;
      }

      final data = jsonDecode(response.body);
      final responseError = data['error'] ?? true;
      final responseMessage = data['message'] ?? 'Unknown response';

      setState(() {
        status = !responseError;
        message = responseMessage;
      });

      if (responseError) {
        Fluttertoast.showToast(
          msg: responseMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Event updated successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
        );
      }
  }
    on TimeoutException catch (_) {
      debugPrint('Update_event timeout');
      Fluttertoast.showToast(
        msg: 'Request timed out',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
      );
    } on SocketException catch (_) {
      debugPrint('Update_event socket error');
      Fluttertoast.showToast(
        msg: 'Network unreachable',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
      );
    } catch (e, st) {
      debugPrint('Update_event error: $e\n$st');
      Fluttertoast.showToast(
        msg: 'Unexpected error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
      );
    }
  }
}
