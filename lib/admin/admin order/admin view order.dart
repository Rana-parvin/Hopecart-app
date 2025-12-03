import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hopecart/admin/admin order/admin order details.dart';

class Orders {
  final String craftid;
  final String name;
  final String phone;
  final String total;
  final String qnty;
  final String oid;

  Orders({
    required this.craftid,
    required this.name,
    required this.phone,
    required this.total,
    required this.qnty,
    required this.oid,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      craftid: json["craftid"].toString(),
      oid: json["orderid"].toString(),
      name: json["payer_name"].toString(),   // From moneytable
      phone: json["phone"].toString(),
      total: json["payment_total"].toString(),
      qnty: json["quantity"].toString(),
    );
  }
}

class Adminvieworder extends StatefulWidget {
  const Adminvieworder({super.key});

  @override
  State<Adminvieworder> createState() => _AdminvieworderState();
}

class _AdminvieworderState extends State<Adminvieworder> {
  late Future<List<Orders>> ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture = fetchOrders();
  }

  Future<List<Orders>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final orderId = prefs.getString('get_id'); // Must match PHP parameter

    if (orderId == null) return [];

    const String url = "http://192.168.172.163/hopephp/order/adminvieworder.php";

    final response = await http.post(Uri.parse(url), body: {
      "orderid": orderId, // POST key now matches PHP script
    });

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse["error"] == true) return [];

    List data = jsonResponse["orders"];
    return data.map((e) => Orders.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Stack(
                      alignment: Alignment(2.5, -2.5),
                      children: [
                        Icon(Icons.circle_notifications_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 50),
                        Icon(Icons.add_circle,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 27),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Ordered Items",
                      style: GoogleFonts.openSans(
                          fontSize: 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  Text("Support a good cause",
                      style: GoogleFonts.nunito(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
              
                  // ------------------------ Orders List ------------------------
                  FutureBuilder<List<Orders>>(
                    future: ordersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text("Loading..."),
                          ],
                        );
                      }
              
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
              
                      final orders = snapshot.data ?? [];
              
                      if (orders.isEmpty) {
                        return const Text("No records found.");
                      }
              
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (_, index) {
                          final order = orders[index];
              
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderDetailsPage(
                                      orderid: order.oid,
                                      total: order.total,
                                    ),
                                  ),
                                );
                              },
                              title: Text(order.name, style: itemTextStyle()),
                              subtitle: Text(order.phone, style: itemTextStyle()),
                              trailing: Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.amber,
                                child: Text(order.total, style: itemTextStyle()),
                              ),
                            ),
                          );
                        },
                      );
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

  TextStyle itemTextStyle() =>
      GoogleFonts.lora(color: Colors.grey.shade700, fontSize: 16);
}
