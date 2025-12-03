import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hopecart/user/user craft/cart item details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Cart Item Model
class Cartitems {
  final String id;
  final String name;
  final String image;
  final String price;
  final String qnty;
  final String des;

  Cartitems({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qnty,
    required this.des,
  });
}

class ViewCart extends StatefulWidget {
  const ViewCart({super.key});

  @override
  State<ViewCart> createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  late Future<List<Cartitems>> _cartFuture;

  @override
  void initState() {
    super.initState();
    _cartFuture = getCartItems();
  }

  Future<List<Cartitems>> getCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString("user_id");

      if (uid == null || uid.isEmpty) return [];

      final response = await http.post(
        Uri.parse("http://192.168.39.163/hopephp/cart/viewcart.php"),
        body: {"Uid": uid},
      );

      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);

      if (data is! List) return [];

      return data.map<Cartitems>((item) {
        return Cartitems(
          id: item["cartid"].toString(),
          name: item["name"].toString(),
          image: item["image"].toString(),
          price: item["price"].toString(),
          qnty: item["quantity"].toString(),
          des: item["description"].toString(),
        );
      }).toList();
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  double getTotal(List<Cartitems> items) {
    double total = 0;
    for (var item in items) {
      final price = double.tryParse(item.price.replaceAll(RegExp(r'[^0-9.\-]'), '')) ?? 0;
      final qty = double.tryParse(item.qnty.replaceAll(RegExp(r'[^0-9.\-]'), '')) ?? 1;
      total += price * qty;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: const Color(0xFFF6F5FF),
      appBar: AppBar(centerTitle: true,
       // backgroundColor: Colors.deepOrange,
        title: Text(
          "My Cart",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<List<Cartitems>>(
        future: _cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(child: Text("Your cart is empty."));
          }

          final totalAmount = getTotal(items);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Cartitemdetails(item: item),
                            ),
                          );
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: item.image.isNotEmpty
                              ? Image.network(item.image, width: 60, height: 60, fit: BoxFit.cover)
                              : Image.asset("assets/images/meal.jpeg", width: 60, height: 60, fit: BoxFit.cover),
                        ),
                        title: Text(
                          item.name,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "₹${item.price} x ${item.qnty}",
                          style: GoogleFonts.nunito(fontSize: 13, color: Colors.grey[700]),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total: ₹${totalAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Checkout functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Checkout", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
