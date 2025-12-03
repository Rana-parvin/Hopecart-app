import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/customfield1.dart';
import 'package:hopecart/user/user%20food/viewbookedfd.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Foodbooking extends StatefulWidget {
  const Foodbooking({super.key});

  @override
  State<Foodbooking> createState() => _FoodbookingState();
}

class _FoodbookingState extends State<Foodbooking> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  //TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController foodtype = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController specify = TextEditingController();

  late bool status;

  String? userKey;
  late String message;
  String _selectedSize = "Small";
  String? username;

  @override
  void initState() {
    super.initState();

    getValidationData();
    // name = TextEditingController();
    date = TextEditingController();
    foodtype = TextEditingController();
    quantity = TextEditingController();
    specify = TextEditingController();

    status = false;
    message = "";
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Icon(
                      Icons.fastfood,
                      size: 50,
                      color: Color(0xFFF47C2C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    " Checkout Details",
                    style: GoogleFonts.openSans(
                      fontSize: 30,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),
                  Text(
                    "Handcrafted With Love",
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                 Padding(
                 padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Row(
                   children: [
                     Icon(Icons.person, color: Colors.grey),
                     SizedBox(width: 10),
                      Text(
                      "Ordered by: $username",
                   style: TextStyle(
                    fontSize: 16,
                     fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                     ),
                  ],
                ),
                 ),

                  customfield1(
                    prefixicon: Icon(Icons.calendar_month_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
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
                                onPrimary: Colors.white,
                                onSurface: const Color.fromARGB(
                                  255,
                                  247,
                                  159,
                                  101,
                                ),
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
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
                      });
                    },
                    controller: date,
                    hinttext: "Booking Date",
                    borderRadius: BorderRadius.circular(10),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: customfield(
                      hinttext: "Food",
                      controller: foodtype,
                      prefixicon: Icon(Icons.restaurant),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a food type';
                        }
                        return null;
                      },
                      obscuretext: false,
                    ),
                  ),

                  //quantity,specification
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: customfield(
                          hinttext: "Quantity",
                          controller: quantity,
                          keyboardtype: TextInputType.number,
                          prefixicon: Icon(Icons.shopping_cart_checkout),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter quantity';
                            }
                            return null;
                          },
                          obscuretext: false,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField(
                          initialValue: _selectedSize,
                          items: const [
                            DropdownMenuItem(
                              value: "Small",
                              child: Text("Small"),
                            ),
                            DropdownMenuItem(
                              value: "Medium",
                              child: Text("Medium"),
                            ),
                            DropdownMenuItem(
                              value: "Large",
                              child: Text("Large"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedSize = value.toString());
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.monitor_weight,
                            ), // similar to textfield prefix icon
                            labelText: "Size",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // match your textfield radius
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ), // normal border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ), // on focus
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: customfield(
                      hinttext: "Specifications(eg:no sugar,no salt)",
                      controller: specify,
                      prefixicon: Icon(Icons.note_alt_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter... ';
                        }
                        return null;
                      },
                      obscuretext: false,
                    ),
                  ),
                  SizedBox(height: 20),
                  formbutton(
                    height: screenheight / 17,
                    width: screenwidth / 1.1,
                    text: "Book Now",
                    onpressed: () async {
                      if (formkey.currentState!.validate()) {
                        await Registration();
                      }
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

  Future<void> Registration() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var uid = sharedprefs.getString('user_id');
    print(uid);
    var APIURL = "http://192.168.172.163/hopephp/food/foodbooking.php";

    //json maping user entered details
    Map mapeddate = {
      'uid': uid,
      'name': username,
      'date': date.text,
      'foodtype': foodtype.text,
      'specify': specify.text.trim(),
      'quantity': quantity.text.trim(),
      'size': _selectedSize,
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failde to book your food')));
    } else {
      setState(() {
        status = true;
        message = responseMessage;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Food booked successfully')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Viewbookedfd()),
      );
    }

    print("DATA: $data");
  }

  Future<void> getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = sharedprefs.getString('user_id');
    var savedUsername = sharedprefs.getString('username');

    setState(() {
      userKey = obtainedemail;
      username = savedUsername ?? "User";
    });
    print('this is service  value $userKey');
  }
}
