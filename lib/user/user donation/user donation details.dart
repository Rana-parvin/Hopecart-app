import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user view donation.dart';

class DonationDetails extends StatelessWidget {
  final Userdonations donate;

  const DonationDetails({super.key, required this.donate});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F5FF),
      appBar: AppBar(centerTitle: true,
  title: Text(
          "Donation Details",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Avatar / Icon
               // TOP CARD WITH ICON + NAME
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.shade200,
                      Colors.deepOrange.shade500,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6))
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.volunteer_activism,
                          size: 50, 
                          color: Theme.of(context).colorScheme.secondary
                          ),
                    ),
                    const SizedBox(height: 15),

                    Text("Donation Details",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),

                    const SizedBox(height: 6),
                    Text("Support a Good Cause",
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Donor Details Card
              buildSection(
                title: "Donor Details",
                children: [
                  buildDetailRow("Name", donate.name),
                  buildDetailRow("Location", donate.place),
                  buildDetailRow("Phone", donate.phone),
                ],
              ),

              const SizedBox(height: 20),

              // Bank Details Card
              buildSection(
                title: "Bank Details",
                children: [
                  buildDetailRow("Bank Name", donate.bank),
                  buildDetailRow("Account Number", donate.account),
                  buildDetailRow("Amount Donated", "\$${donate.amount}"),
                ],
              ),

              const SizedBox(height: 30),

              // Done Button
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section Card Builder
  Widget buildSection({required String title, required List<Widget> children}) {
    return Card(
      elevation: 5,
      shadowColor: Colors.deepOrange.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  // Single Detail Row Builder
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
