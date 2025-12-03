import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/button/formbutton.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/customfield1.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class add_events extends StatefulWidget {
  const add_events({super.key});

  @override
  _add_eventsState createState() => _add_eventsState();
}

class _add_eventsState extends State<add_events> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController description = TextEditingController();

  late bool status;
  late String message;

  @override
  void initState() {
    // name = TextEditingController();
    // date = TextEditingController();
    // time = TextEditingController();
    // description = TextEditingController();

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: true,
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
                Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15),
                       child: customfield(hinttext: "Event name", 
                       controller: name,
                        prefixicon: Icon(Icons.edit),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please give the event name";
                            }
                            return null;
                          }, obscuretext: false),
                     ),
                
                      //  SizedBox(height: 10),
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
                            date.text = formattedDate;
                            //set output date to TextField value.
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please choose a date";
                          }
                          return null;
                        },
                        controller: date,
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
                        controller: time,
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
                              time.text = pickedtime.format(context);
                            });
                          }
                        },
                      ),
                
                      // SizedBox(height: 10),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15),
                       child: customfield(hinttext: "Description",
                        controller: description,
                         prefixicon: Icon(Icons.description), 
                           validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please give a small discription";
                            }
                            return null;
                          }, 
                         obscuretext: false),
                     ),
                      SizedBox(height: 30),
                      formbutton( height: screensize / 20,
                        width: screenwidth / 1.5,
                       text: "Add Event",  
                       onpressed: () async{
                            if (formkey.currentState!.validate()) {
                             
                              await  addevent();
                            
                            }
                          },
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> addevent() async {
    const apiUrl = "http://192.168.123.163/hopephp/event/addevent.php";

    final Map<String, String> mapeddate = {
      'name': name.text.trim(),
      'date': date.text.trim(),
      'time': time.text.trim(),
      'description': description.text.trim(),
    };
     debugPrint('addevent: mapeddate = $mapeddate'); // <--- add this


    try {      
      final response = await http
          .post(Uri.parse(apiUrl), body: mapeddate)
          .timeout(const Duration(seconds: 15));
       debugPrint('addevent: request sent');
      debugPrint('addevent: status=${response.statusCode} body=${response.body}');

      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Server error (non-200)')),
        );
        return false;
      }

      final data = jsonDecode(response.body);
      final responseError = data['error'] ?? true;
      final responseMessage = data['message'] ?? 'Unknown server response';

      if (responseError == true) {
        setState(() {
          status = false;
          message = responseMessage;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseMessage)),
        );
        return false;
      } else {
        setState(() {
          status = true;
          message = responseMessage;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added successfully')),
        );
        // clear form after success
        name.clear();
        date.clear();
        time.clear();
        description.clear();
        return true;
      }
    } on TimeoutException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request timed out')),
      );
      return false;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network unreachable')),
      );
      return false;
    } catch (e) {
      debugPrint('addevent unexpected error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unexpected error')),
      );
      return false;
    }
  }

}

