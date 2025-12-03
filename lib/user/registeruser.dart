import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/user/loginuser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Registeruser extends StatefulWidget {
  const Registeruser({super.key});

  @override
  State<Registeruser> createState() => _RegisteruserState();
}

class _RegisteruserState extends State<Registeruser> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isvisible = false;

  late bool status;
  late String message;

 @override
  void initState() {
    super.initState();
  
    status = false;
    message = "";
  }

   @override
  void dispose() {
   username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // var screensize = MediaQuery.of(context).size.height;
    return Scaffold(resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
          //  height: screensize*0.8,,.
            width: double.infinity,
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
                      Icon(Icons.favorite, color: Color(0xFFFFF4E1), size: 30),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                    children: [
                      Text(
                        " Sign up",
                        style:GoogleFonts.openSans( fontSize: 30,letterSpacing: 1,
                          fontWeight: FontWeight.w600,),
                      ),
                      SizedBox(height: 5,),
                      Text("Support a good cause",style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.w500),),
                      SizedBox(height: 20,),

                      customfield(
                        controller: username,
                        hinttext: "Username",
                        prefixicon: Icon(Icons.person_rounded),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid username";
                          }
                          return null;
                        },
                        obscuretext: false,
                      ),
                      customfield(
                        keyboardtype: TextInputType.emailAddress,
                        hinttext: "Email",
                        controller: email,
                        prefixicon: Icon(Icons.email),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email id";
                          }
                          return null;
                        },
                        obscuretext: false,
                      ),
                      customfield(
                        hinttext: "password",
                    
                        controller: password,
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
                            return "Please create a password";
                          }
                          return null;
                        },
                        obscuretext: isvisible,
                      ),
                    
                      customfield(
                        keyboardtype: TextInputType.numberWithOptions(),
                        hinttext: "Phone",
                        controller: phone,
                        prefixicon: Icon(Icons.call),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your phone no";
                          }
                          return null;
                        },
                        obscuretext: false,
                      ),
                      SizedBox(height: 20,),
                      SizedBox(width: 200,
                        child: ElevatedButton(
                          onPressed: () async{
                            if (formkey.currentState!.validate()) {
                             
                           await     Registration();
                             
                            }
                          },
                             style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF47C2C), // your desired color
                     shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // rounded rectangle
                           ),
                         padding: const EdgeInsets.symmetric(vertical: 14), // good height
                    elevation: 3, // optional: adds a soft shadow
                          ), child: Text('sign up',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loginuser(),
                                ),
                              );
                            },
                            child: Text(
                              "sign in",
                              style: TextStyle(    color: Theme.of(context).colorScheme.secondary,                       
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
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

  Future<void> Registration() async {
    if (!formkey.currentState!.validate()) return;

    const APIURL = "http://192.168.39.163/hopephp/login/user_reg.php";

    // debug: show what will be sent
    final u = username.text.trim();
    final e = email.text.trim();
    final p = phone.text.trim();
    final pwd = password.text;
    debugPrint('Registration: username="$u", email="$e", phone="$p", password="${pwd.isNotEmpty ? '[REDACTED]' : ''}"');


    // show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final Map<String, String> mapeddate = {
      'username': u,
      'email': e,
      'phone': p,
      'password': pwd,
    };

    debugPrint('Registration: sending => $mapeddate');

    try {
      final response = await http
          .post(Uri.parse(APIURL), body: mapeddate)
          .timeout(const Duration(seconds: 15));

      debugPrint('Registration: status=${response.statusCode} body=${response.body}');

      // close loading
      if (Navigator.canPop(context)) Navigator.pop(context);

      if (response.statusCode != 200) {
        Fluttertoast.showToast(msg: 'Server error (${response.statusCode})');
        return;
      }

      final data = jsonDecode(response.body);
      final responseError = data['error'] ?? true;
      final responseMessage = data['message'] ?? 'Unknown server response';

      setState(() {
        status = !responseError;
        message = responseMessage;
      });

      if (responseError) {
        Fluttertoast.showToast(
          msg: responseMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Registration successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // clear fields and navigate to login
        username.clear();
        email.clear();
        phone.clear();
        password.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Loginuser()),
        );
      }
    } on TimeoutException catch (_) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Request timed out', backgroundColor: Colors.red, textColor: Colors.white);
    } on SocketException catch (_) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Network unreachable', backgroundColor: Colors.red, textColor: Colors.white);
    } catch (e, st) {
      debugPrint('Registration error: $e\n$st');
      if (Navigator.canPop(context)) Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Unexpected error', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

}

