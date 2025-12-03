import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/user/bottom navigation/bottom nav.dart';
import 'package:hopecart/user/registeruser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loginuser extends StatefulWidget {
  const Loginuser({super.key});

  @override
  State<Loginuser> createState() => _LoginuserState();
}

class _LoginuserState extends State<Loginuser> {
  TextEditingController namec = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isvisible = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
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
                SizedBox(height: 20),
                Text(
                  " Sign in",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Support a good cause",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 60),

                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      customfield(
                        hinttext: "username",
                        controller: namec,
                        prefixicon: Icon(Icons.person_sharp),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter a valid username";
                          }
                          return null;
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
                            setState(() => isvisible = !isvisible);
                          },
                          icon: isvisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter a valid password";
                          }
                          return null;
                        },
                        obscuretext: !isvisible,
                      ),

                      SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: loading
                              ? null
                              : () async {
                                  if (formkey.currentState!.validate()) {
                                    await loginuser();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF47C2C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 3,
                          ),
                          child: loading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'sign in',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Registeruser(),
                                ),
                              );
                            },
                            child: Text(
                              'sign up',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
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

  Future<void> loginuser() async {
    setState(() => loading = true);

    try {
      final url = "http://192.168.39.163/hopephp/login/loginuser.php";

      final response = await http
          .post(
            Uri.parse(url),
            body: {
              "username": namec.text.trim(),
              "password": passwordc.text.trim(),
            },
          )
          .timeout(const Duration(seconds: 15));

      debugPrint(
        'loginuser: status=${response.statusCode} body=${response.body}',
      );

      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
        if (mounted) setState(() => loading = false);
        return;
      }

      dynamic data;
      try {
        data = json.decode(response.body);
      } catch (e) {
        debugPrint('loginuser: invalid JSON: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid server response')));
        if (mounted) setState(() => loading = false);
        return;
      }

      debugPrint('loginuser: parsed data: $data');

      // Determine success from common response shapes:
      bool isSuccess = false;
      if (data is Map) {
        // PHP used 'error' (false on success) and returns 'user' object
        if (data.containsKey('success')) {
          final sv = data['success'];
          isSuccess = sv == true || sv == '1' || sv == 1 || sv == 'true';
        } else if (data.containsKey('error')) {
          final ev = data['error'];
          // treat boolean false, 'false', 0, '0' as success
          isSuccess =
              (ev == false) || (ev == 'false') || (ev == 0) || (ev == '0');
        } else if (data.containsKey('user')) {
          isSuccess = data['user'] != null;
        }
      }

      debugPrint('loginuser: isSuccess=$isSuccess');

      if (!isSuccess) {
        final serverMessage = (data is Map && data['message'] != null)
            ? data['message']
            : 'Invalid username or password';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(serverMessage)));
        if (mounted) setState(() => loading = false);
        return;
      }

      // extract user id from data['user'] if present, else fallback to top-level ids
      String? id;
      String? email;
      String? username;
      if (data is Map && data['user'] is Map) {
        final user = data['user'];
        id = user['id']?.toString();
        email = user['email']?.toString();
        username = user['username']?.toString() ?? user['name']?.toString();
      } else {
        id = (data['id'] ?? data['user_id'] ?? data['userid'] ?? data['uid'])
            ?.toString();
        email = (data['email'] ?? data['user_email'])?.toString();
        username = (data['username'] ?? data['user_name'] ?? data['name'])
            ?.toString();
      }

      if (id == null) {
        debugPrint('loginuser: no id in response: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Login succeeded but server returned incomplete user data',
            ),
          ),
        );
        if (mounted) setState(() => loading = false);
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", id);
      if (email != null) await prefs.setString("email", email);
      if (username != null) await prefs.setString("username", username);

      if (!mounted) return;
      setState(() => loading = false);

      Fluttertoast.showToast(msg: "Logged in successfully!",backgroundColor: Theme.of(context).colorScheme.secondary);
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text("Login successful"),backgroundColor: Colors.lime,));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
    } on TimeoutException catch (e) {
      debugPrint('loginuser timeout: $e');
      if (mounted) setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Request timed out')));
    } on SocketException catch (e) {
      debugPrint('loginuser socket error: $e');
      if (mounted) setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Network unreachable')));
    } catch (e) {
      debugPrint('loginuser error: $e');
      if (mounted) setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unexpected error: $e')));
    }
  }
}



//sharedpref for user
//   to use emailid=>  getstring('email')
//   to use username=> getstring('username')
//   to use userid=> getstring('user_id')