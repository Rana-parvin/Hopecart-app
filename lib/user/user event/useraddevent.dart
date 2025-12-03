import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/button/formbutton.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/customfield1.dart';
import 'package:hopecart/user/homeuser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Useraddevent extends StatefulWidget {
  const Useraddevent({super.key});

  @override
  _UseraddeventState createState() => _UseraddeventState();
}

class _UseraddeventState extends State<Useraddevent> {
  TextEditingController evname = TextEditingController();

  TextEditingController date = TextEditingController();

  TextEditingController time = TextEditingController();

  TextEditingController description = TextEditingController();

  late bool status;

  late String message;

  @override
  void initState() {
    evname = TextEditingController();
    date = TextEditingController();
    time = TextEditingController();
    description = TextEditingController();

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenheight= MediaQuery.of(context).size.height;
    var screenwidth= MediaQuery.of(context).size.width; 
        return Scaffold(resizeToAvoidBottomInset: true,
       appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
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
                      Icons.add_circle,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 23,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                      " Add Event",
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
                      ),
                    ),
                    SizedBox(height: 20),

              customfield(hinttext: "Event name",
               controller: evname,
                prefixicon: Icon(Icons.event),
                 validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a Date";
                  }
                  return null;
                }, 
                 obscuretext: false),
             
              customfield1(
                prefixicon: Icon(Icons.calendar_today_outlined),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a Date";
                  }
                  return null;
                } ,
               controller: date,
                hinttext: "Date", 
                borderRadius: BorderRadius.circular(20),
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
                            primary: Colors.green, // <-- SEE HERE
                            onPrimary: Colors.white, // <-- SEE HERE
                            onSurface:
                                Colors.green.shade900, // <-- SEE HERE
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
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickeddate!);
                  setState(() {
                    date.text = formattedDate;
                    //set output date to TextField value.
                  });
                },
                ),
              
              customfield1(
                
                validator:  (value) {
                  if (value!.isEmpty) {
                    return "Please enter a time";
                  }
                  return null;
                },
                prefixicon: Icon(Icons.timer),
              controller: time,
               hinttext: "Time",
                borderRadius: BorderRadius.circular(20),
                 ontap: () async {
                  var _time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
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
                  if (_time != null) {
                    setState(() {
                      time.text = _time.format(context);
                    });
                  }
                },
                ),
            
             customfield(hinttext: "Description",
              controller: description, prefixicon: Icon(Icons.edit),
               validator:  (value) {
                  if (value!.isEmpty) {
                    return "Please enter a Description";
                  }
                  return null;
                }, 
               obscuretext: false),
              SizedBox(
                height: 30,
              ),
             formbutton(
              height:screenheight/ 20,
                width: screenwidth / 1.5,
                                 text: 'Add event',
              onpressed: (){
                     getValidationData();
              }),
              
            ],
          ),
        ),
      ),
    );
  }

  String? user_key;
  Future getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = sharedprefs.getString('get_id');
    setState(() {
      user_key = obtainedemail;
    });
    print('thisis service  value $user_key');
  }

  Future<void> Registration() async {
    var APIURL = "http://192.168.39.163/hopephp/event/addevent.php";
    //
    //json maping user entered details
    Map mapeddate = {
      'id': user_key.toString(),
      'name': evname.text,
      'date': date.text,
      'time': time.text,
      'description': description.text
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: mapeddate);
    print(mapeddate);
    print("cvcvvf");
    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    print(data);
    var responseMessage = data["message"];
    var responseError = data["error"];
    print("DATA: $data");
    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
      Fluttertoast.showToast(
        msg: responseMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        webPosition: 1,
        // backgroundColor: Colors.blueGrey
      );
    } else {
      setState(() {
        status = true;
        message = responseMessage;
      });

      Fluttertoast.showToast(
        msg: 'Event Added Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserHome()));
    }

    print("DATA: $data");
  }
}
