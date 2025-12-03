import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/button/formbutton.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/user/user%20order/vieworders.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class order_form extends StatefulWidget {
  final String amount;
  const order_form({super.key, required this.amount});

  @override
  _order_formState createState() => _order_formState();
}

class _order_formState extends State<order_form> {
  TextEditingController _name = TextEditingController();

  TextEditingController _phone = TextEditingController();

  TextEditingController _bank = TextEditingController();

  TextEditingController _account = TextEditingController();

  late bool status;

  late String message;

  get total => widget.amount;

  @override
  void initState() {
     super.initState();
    _name = TextEditingController();
    _phone = TextEditingController();
    _bank = TextEditingController();
    _account = TextEditingController();
    status = false;
    message = "";
    // load user id from prefs
    getValidationData();
  }
  

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Stack(
                    alignment: Alignment(1, -3),
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 50,
                        color: Color(0xFFF47C2C),
                      ),
                      // Icon(Icons.square, color: Color(0xFFF47C2C), size: 33),
                      Icon(Icons.add, color: Color(0xFFF47C2C), size: 30),
                    ],
                  ),
                ),
                //   const  SizedBox(height: 20,),
                Text(
                  " Checkout Details",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Handcrafted With Love",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //  const   SizedBox(height: 20,),
                //  Text("Checkout Details",style: GoogleFonts.bitter(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 20),),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Total Amount : ",
                      style: GoogleFonts.bitter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "₹ $total",
                      style: GoogleFonts.lora(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                customfield(
                  hinttext: "Name",
                  controller: _name,
                  prefixicon: Icon(Icons.edit),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a Name";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),

                customfield(
                  hinttext: "Phone number",
                  controller: _phone,
                  prefixicon: Icon(Icons.call),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a phone number";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),

                customfield(
                  hinttext: "Bank name",
                  controller: _bank,
                  prefixicon: Icon(Icons.account_balance_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the bank name";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),

                customfield(
                  hinttext: "Account number",
                  controller: _account,
                  prefixicon: Icon(Icons.pin),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your account number";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),
                SizedBox(height: 20),
                formbutton(
                  height: screenheight / 20,
                  width: screenwidth / 2,
                  text: "Book Now",
                  onpressed: () async {
                    if (formkey.currentState!.validate()) {
                      await order();
                    }
                  },
                ),
                SizedBox(height: 40),
              ],
            ),

            //],
          ),
        ),
      ),
    );
  }

  String? user_key;
  Future getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = sharedprefs.getString('user_id');
    setState(() {
      user_key = obtainedemail;
    });
    print('thisis service  value $user_key');
  }

  Future<void> order() async {
    if (_name.text.trim().isEmpty ||
        _phone.text.trim().isEmpty ||
        _bank.text.trim().isEmpty ||
        _account.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => status = true); // optional: show UI loading if you use status

     try{

       final SharedPreferences prefs = await SharedPreferences.getInstance();
     final uid = prefs.getString('user_id');
     if (uid == null || uid.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User ID missing — please login again")));
        setState(() => status = false);
        return;
      }

      final apiUrl = "http://192.168.39.163/hopephp/order/orderform.php";

      final Map<String, String> requestData = {
        'Uid': uid, // use lowercase 'uid' consistently
        'name': _name.text.trim(),
        'phone': _phone.text.trim(),
        'bank': _bank.text.trim(),
        'account': _account.text.trim(),
        'total': total.toString(),
      };

     debugPrint('order: sending => $requestData');

      final response = await http.post(Uri.parse(apiUrl), body: requestData).timeout(const Duration(seconds: 15));
      debugPrint('order: status=${response.statusCode} body=${response.body}');

      if (response.statusCode != 200) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Server error: ${response.statusCode}')));
        setState(() => status = false);
        return;
      }

      dynamic data;

       try {
        data = jsonDecode(response.body);
      } on FormatException {
        debugPrint('order: invalid JSON response');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid server response')));
       setState(() => status = false);
        return;
      }

      final bool error = (data is Map && (data['error'] == true || data['error'] == 'true' || data['error'] == 1));
      final String messageServer = (data is Map && data['message'] != null) ? data['message'].toString() : 'Something went wrong';

      if (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messageServer), backgroundColor: Colors.red));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order placed successfully"), backgroundColor: Colors.green));
        _name.clear();
        _phone.clear();
        _bank.clear();
        _account.clear();
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
      }
     } on TimeoutException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request timed out'), backgroundColor: Colors.red));
    } on SocketException {
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Network unreachable'), backgroundColor: Colors.red));
    } catch (e, st) {
      debugPrint('order error: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unexpected error — try again'), backgroundColor: Colors.red));
    } finally {
      setState(() => status = false);
    }

  }
}
