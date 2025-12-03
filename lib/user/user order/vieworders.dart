import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Orderedcraft {
  final String id;
  final String name;
  final String image;
  final String price;
  final String qnty;
  final String craftid;

  Orderedcraft({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qnty,
    required this.craftid,
  });
}

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late Future<List<Orderedcraft>> orderList;

  @override
  void initState() {
    super.initState();
    orderList = getRequest();
  }

  Future<List<Orderedcraft>> getRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('user_id');
    String url = "http://192.168.172.163/hopephp/order/vieworders.php?id=$uid";

    var response = await http.get(Uri.parse(url));
    List data = jsonDecode(response.body);

    return data.map((item) {
      return Orderedcraft(
        id: item["id"].toString(),
        name: item["name"],
        image: item["image"],
        price: item["price"],
        qnty: item["quantity"],
        craftid: item["craftid"],
      );
    }).toList();
  }

  Future<void> deleteRecord(String id) async {
    String url = "http://192.168.172.163/hopephp/order/cancelorder.php";
    await http.post(Uri.parse(url), body: {"id": id});
    setState(() => orderList = getRequest());
  }

  String totalAmount(List<Orderedcraft> items) {
    double total = 0;
    for (var item in items) {
      total += double.parse(item.price) * double.parse(item.qnty);
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          "My Orders",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: orderList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No orders found"),
            );
          }

          List<Orderedcraft>? items = snapshot.data;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Support a good cause ❤️",
                  style: GoogleFonts.nunito(fontSize: 16),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items?.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final item = items?[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item!.image,
                            height: 55,
                            width: 55,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.image),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "Qty: ${item.qnty}   ×   ₹${item.price}",
                          style: GoogleFonts.nunito(fontSize: 14),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text("Delete this item?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        deleteRecord(item.craftid);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("YES")),
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("NO")),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.blueGrey.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "₹ ${totalAmount(items!)}",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
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
