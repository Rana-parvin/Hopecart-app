import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopecart/user/user%20donation/user%20view%20donation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({super.key});

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
  final TextEditingController name = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController account = TextEditingController();

  String? userKey;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadUserKey();
  }

  Future<void> loadUserKey() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userKey = prefs.getString('user_id');
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F5FF),
      appBar: AppBar(
        title: Text(
          "Add Donation",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Header
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Stack(
                      alignment: Alignment(1, -1.1),
                      children: const [
                        Icon(Icons.attach_money_outlined,
                            size: 60, color: Color(0xFFF47C2C)),
                        Icon(Icons.favorite, size: 20, color: Color(0xFFF47C2C)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Support a Good Cause",
                    style: GoogleFonts.openSans(
                        fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Fill in your donation details below",
                    style:
                        GoogleFonts.nunito(fontSize: 15, color: const Color.fromARGB(255, 103, 101, 101)),
                  ),
                  const SizedBox(height: 25),

                  // Donor Details Section
                  buildSection(
                    title: "Donor Details",
                    children: [
                      buildField(name, "Donator's Name", Icons.person),
                      buildField(place, "Your Location", Icons.location_on),
                      buildField(phone, "Phone Number", Icons.call,
                          keyboard: TextInputType.phone),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Bank Details Section
                  buildSection(
                    title: "Bank Details",
                    children: [
                      buildField(bank, "Bank Name", Icons.account_balance),
                      buildField(amount, "Donation Amount",
                          Icons.monetization_on_outlined,
                          keyboard: TextInputType.number),
                      buildField(account, "Account Number", Icons.account_box,
                          keyboard: TextInputType.number),
                    ],
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async{
                        if (formKey.currentState!.validate()) {
                         await submitDonation();
                        }
                      },
                      child: Text(
                        "Donate",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required List<Widget> children}) {
    return Card(
      elevation: 5,
      shadowColor: Colors.deepOrange.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildField(TextEditingController controller, String hintText, IconData icon,
    {TextInputType keyboard = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $hintText";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100], // Light background
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
      ),
    ),
  );
}


  Future<void> submitDonation() async {
    final uid = userKey;
    if (uid == null) {
      Fluttertoast.showToast(
          msg: "User not logged in",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      return;
    }

    const apiUrl =
        "http://192.168.39.163/hopephp/moneydonation/adddonation.php";

    Map<String, String> data = {
      'uid': uid,
      'name': name.text.trim(),
      'place': place.text.trim(),
      'phone': phone.text.trim(),
      'amount': amount.text.trim(),
      'bank': bank.text.trim(),
      'account': account.text.trim(),
    };

    try {
      final response = await http.post(Uri.parse(apiUrl), body: data);
      final responseData = jsonDecode(response.body);

      bool error = responseData['error'];
      String message = responseData['message'];

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: error ? Colors.red : Colors.green,
          textColor: Colors.white);

      if (!error) {
        name.clear();
        place.clear();
        phone.clear();
        amount.clear();
        bank.clear();
        account.clear();

        Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => ViewDonation(showappbar: true,)),
  );
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Network error: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }
}
