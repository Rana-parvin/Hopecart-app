import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/button/formbutton.dart';
import 'admin_view_donation.dart';

class donationdetails extends StatefulWidget {
  final Donation_details donate;

  const donationdetails({super.key, required this.donate});

  @override
  _donationdetailsState createState() => _donationdetailsState();
}

class _donationdetailsState extends State<donationdetails> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Icon(
                    Icons.volunteer_activism,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 45,
                  ),
                ),
                Text(
                  " Details",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            const    SizedBox(height: 5),
                Text(
                  "Support a good cause",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
            const    SizedBox(height: 20),

                Center(
                  child: Container(
                    height: screenheight * 0.5,
                    width: screenwidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        //Details
                        buildlabel("NAME :"),
                        buildvalue(widget.donate.name),

                        buildlabel("PLACE :"),
                        buildvalue(widget.donate.place),

                        buildlabel("PHONE :"),
                        buildvalue(widget.donate.phone),

                        buildlabel("AMOUNT :"),
                        buildvalue(widget.donate.amount),

                        buildlabel("BANK NAME :"),
                        buildvalue(widget.donate.bank),

                        buildlabel("ACCOUNT NUMBER :"),
                        buildvalue(widget.donate.account),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                formbutton(
                  height: 50,
                  width: screenwidth * 0.6,
                  onpressed: () {
                    Navigator.pop(context);
                  },
                  text: "send a heart",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildlabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 2),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildvalue(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 45, bottom: 15),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
