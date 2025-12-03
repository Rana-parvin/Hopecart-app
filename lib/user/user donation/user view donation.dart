import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'user donation details.dart';

class Userdonations {
  final String id;
  final String name;
  final String place;
  final String phone;
  final String amount;
  final String bank;
  final String account;

  Userdonations({
    required this.id,
    required this.name,
    required this.place,
    required this.phone,
    required this.amount,
    required this.bank,
    required this.account,
  });
}

class ViewDonation extends StatefulWidget {
  final bool showappbar;
  const ViewDonation({super.key, required this.showappbar});

  @override
  _ViewDonationState createState() => _ViewDonationState();
}

class _ViewDonationState extends State<ViewDonation> {
  Future<List<Userdonations>> getRequest() async {
    final SharedPreferences sh = await SharedPreferences.getInstance();
    var ui = sh.getString('user_id');
    String url =
        "http://192.168.39.163/hopephp/moneydonation/userviewdonation.php?uid=$ui";

    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);

    List<Userdonations> users = [];
    for (var singleUser in responseData) {
      users.add(
        Userdonations(
          id: singleUser["id"].toString(),
          name: singleUser["name"].toString(),
          place: singleUser["place"].toString(),
          phone: singleUser["phone"].toString(),
          amount: singleUser["amount"].toString(),
          bank: singleUser["bank"].toString(),
          account: singleUser["account"].toString(),
        ),
      );
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color(0xFFF6F5FF),
      appBar:widget.showappbar?   AppBar(
      //  backgroundColor: Colors.deepOrange,
        title: Text(
        "My Donations",
        style: GoogleFonts.petrona(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: const Color(0xFF76421E),
        ),
      ),
      ) : null,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<Userdonations>>(
          future: getRequest(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Failed to load: ${snapshot.error}'));
            }
      
            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'No donations found.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
      
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                final donation = items[index];
      
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonationDetails(donate: snapshot.data![index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    shadowColor: Colors.deepOrange.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row with donor name and phone
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.deepOrange,
                                child: Text(
                                  donation.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    donation.name,
                                    style: GoogleFonts.lora(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    donation.phone,
                                    style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "\$${donation.amount}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Bank & location details
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.deepOrange,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                donation.place,
                                style: GoogleFonts.nunito(
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.account_balance,
                                color: Colors.deepOrange,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                donation.bank,
                                style: GoogleFonts.nunito(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Account Number
                          Row(
                            children: [
                              const Icon(
                                Icons.account_box,
                                color: Colors.deepOrange,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                donation.account,
                                style: GoogleFonts.nunito(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
