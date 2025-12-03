import 'package:flutter/material.dart';
import 'package:hopecart/user/user event/userviewevent.dart';
import 'package:google_fonts/google_fonts.dart';

class Usereventdetails extends StatefulWidget {
  final Userevents event;

  const Usereventdetails({super.key, required this.event});

  @override
  _UsereventdetailsState createState() => _UsereventdetailsState();
}

class _UsereventdetailsState extends State<Usereventdetails> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   // var screenwidth = MediaQuery.of(context).size.width;
   // var screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Event Details",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [

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
                      child: Icon(Icons.event,
                          size: 50, 
                          color: Theme.of(context).colorScheme.secondary
                          ),
                    ),
                    const SizedBox(height: 15),

                    Text("Event Details",
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

              // IMAGE / POSTER BOX
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.black12)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  // child: widget.event.imageUrl != null
                  //     ? Image.network(widget.event.imageUrl!,
                  //         fit: BoxFit.cover)
                  //     : Icon(Icons.image, size: 70, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 25),

              // DESCRIPTION CARD
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 5))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     // Event name moved here
                    Text(widget.event.name,
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange.shade700)),
                    const SizedBox(height: 15),
                    Text("Description",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 18)),

                    const SizedBox(height: 10),

                    Text(widget.event.description,
                        style: GoogleFonts.nunito(fontSize: 15)),

                    const SizedBox(height: 20),
                    Divider(),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 20,
                             color:Theme.of(context).colorScheme.secondary
                             ),
                        const SizedBox(width: 10),
                        Text(widget.event.date,
                            style: GoogleFonts.poppins(fontSize: 16)),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 20,
                             color:Theme.of(context).colorScheme.secondary
                            ),
                        const SizedBox(width: 10),
                        Text(
                          "At ${widget.event.time.substring(0, 5)} onwards",
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                             backgroundColor:Theme.of(context).colorScheme.secondary
                      ),
                      child: Text("Participate",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.secondary, width: 2),
                      ),
                      child: Text("Done",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Theme.of(context).colorScheme.secondary)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
