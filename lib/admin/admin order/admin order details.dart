import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String itemId;
  final String craftId;
  final String name;
  final String image;
  final String price;
  final String quantity;

  OrderItem({
    required this.itemId,
    required this.craftId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['itemid'].toString(),
      craftId: json['craft_unique_id'].toString(),
      name: json['craft_name'].toString(),
      image: json['craft_image'].toString(),
      price: json['craft_price'].toString(),
      quantity: json['quantity'].toString(),
    );
  }
}

class OrderDetailsPage extends StatefulWidget {
  final String orderid;
  final String total;
  const OrderDetailsPage({super.key, required this.orderid, required this.total});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late Future<List<OrderItem>> orderItemsFuture;

  @override
  void initState() {
    super.initState();
    orderItemsFuture = fetchOrderItems();
  }

  Future<List<OrderItem>> fetchOrderItems() async {
    const String url = "http://192.168.172.163/hopephp/order/orderdetails.php";
    final response = await http.post(Uri.parse(url), body: {'orderid': widget.orderid});

    if (response.statusCode != 200) throw Exception("Failed to load order details");

    final List data = jsonDecode(response.body);

    if (data.isEmpty) return [];

    return data.map((json) => OrderItem.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
   // final screenHeight = MediaQuery.of(context).size.height;
   // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: FutureBuilder<List<OrderItem>>(
        future: orderItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text("No Data Found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          item.image,
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order ID: ${item.itemId}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text("₹${item.price}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(item.name, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text("Quantity: ${item.quantity}",
                          style: GoogleFonts.lora(color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
