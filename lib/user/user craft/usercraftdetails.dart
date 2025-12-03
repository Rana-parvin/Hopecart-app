import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/user/user craft/view cart.dart';
import 'package:hopecart/user/user%20craft/usercraftview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hopecart/user/user order/user order form.dart';

class Usercraftdetails extends StatefulWidget {
  final Usercrafts item;
  const Usercraftdetails({super.key, required this.item});

  @override
  State<Usercraftdetails> createState() => _UsercraftdetailsState();
}

class _UsercraftdetailsState extends State<Usercraftdetails> {
  String? userKey;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userKey = prefs.getString('user_id');
    });
    debugPrint("Loaded userKey = $userKey");
  }

  @override
  Widget build(BuildContext context) {
  //  var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      // appBar: AppBar(
      //  // backgroundColor: Colors.deepOrange,
      // title: Text(
      //     "Item Details",
      //     style: GoogleFonts.petrona(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 22,
      //       color: const Color(0xFF76421E),
      //     ),
      //   ),      ),
      //  backgroundColor: const Color(0xFFF3F2FF),

      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---- IMAGE HEADER ----
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepOrange, Colors.orangeAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    child: widget.item.image.isEmpty
                        ? Image.asset(
                            "assets/images/meal.jpeg",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.item.image,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                // Positioned(
                //   top: 50,
                //   left: 20,
                //   child: IconButton(
                //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                //     onPressed: () => Navigator.pop(context),
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 20),

            // ---- NAME & PRICE ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text("Item Details",style: GoogleFonts.poppins(fontSize: 25, letterSpacing: 5,fontWeight: FontWeight.w500),),
                  const Divider(thickness: 2,color: Colors.grey,),
                  Text(
                    widget.item.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${widget.item.price}",
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // ---- DESCRIPTION CARD ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.item.description,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ---- ACTION BUTTONS ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  order_form(amount: widget.item.price)),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text("Buy Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: addtocart,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Add To Cart"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> addtocart() async {
    if (userKey == null || userKey!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please log in first")));
      return;
    }

    final craftPrimaryID = widget.item.id.toString();

    final uri = Uri.parse("http://192.168.39.163/hopephp/cart/addtocart.php");

    try {
      final response = await http.post(uri, body: {
        'uid': userKey!,
        'craftid': craftPrimaryID,
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));

        if (body['error'] == false) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ViewCart()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Server Error ${response.statusCode}")));
      }
    } catch (e) {
      debugPrint("addtocart ERROR → $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Network error")));
    }
  }
}
