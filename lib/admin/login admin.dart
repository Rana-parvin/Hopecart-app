import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/bottom%20navigaton/bottom%20navig.dart';
import 'package:hopecart/customfield.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loginadmin extends StatefulWidget {
  const Loginadmin({super.key});

  @override
  State<Loginadmin> createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController adminnamec = TextEditingController();
  TextEditingController passwordc = TextEditingController();

  bool isvisible = false;

  void dispose() {
    adminnamec.dispose();
    passwordc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  var screensize = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            //  height: screensize * 0.7,
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Stack(
                      alignment: Alignment(0, 0.5),
                      children: [
                        Icon(
                          Icons.home_rounded,
                          size: 70,
                          color: Color(0xFFF47C2C),
                        ),
                        Icon(Icons.square, color: Color(0xFFF47C2C), size: 33),
                        Icon(
                          Icons.favorite,
                          color: Color(0xFFFFF4E1),
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    " Sign in",
                    style: GoogleFonts.openSans(
                      fontSize: 27,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Access and manage the platform",
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 60),
                  customfield(
                    hinttext: "Admin name",
                    controller: adminnamec,
                    prefixicon: Icon(Icons.person_sharp),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Admin name';
                      } else {
                        return null;
                      }
                    },
                    obscuretext: false,
                  ),
                  customfield(
                    maxlines: 1,
                    hinttext: "password",
                    controller: passwordc,
                    prefixicon: Icon(Icons.lock),
                    suffixicon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: isvisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                    //shopw text when isvisible==true ,so obscure when not  visible
                    obscuretext: !isvisible,
                  ),

                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          //setState(()  {
                          //call login and wait for the result before navigating
                          login();
                          //  });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFF47C2C,
                        ), // your desired color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // rounded rectangle
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ), // good height
                        elevation: 3, // optional: adds a soft shadow
                      ),
                      child: Text(
                        'sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
  final url = Uri.parse("http://192.168.123.163/hopephp/login/loginadmin.php");
  debugPrint('Login Request => $url');

  try {
    final response = await http.post(
      url,
      body: {
        "adminname": adminnamec.text.trim(),
        "password": passwordc.text.trim(),
      },
    ).timeout(const Duration(seconds: 10));

    debugPrint("Status: ${response.statusCode}");
    debugPrint("Body: ${response.body}");

    // ⚠️ Do NOT block non-200 responses
    if (response.body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Empty response from server")),
      );
      return;
    }

    Map<String, dynamic> body;

    try {
      body = jsonDecode(response.body);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid response: ${response.body}")),
      );
      return;
    }

    if (body['success'] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', body['id'].toString());

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Admin Logged In successfully!')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Bottomnavig()),
      );
    } else {
      final msg = body['message'] ?? "Incorrect Username or Password";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  } on TimeoutException {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Server timeout")),
    );
  } on SocketException {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Network Error")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Unexpected Error: $e")),
    );
  }
}

}
