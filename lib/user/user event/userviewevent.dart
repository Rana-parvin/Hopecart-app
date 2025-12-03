import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/user/user%20event/usereventdetails.dart';
import 'package:http/http.dart' as http;

class Userevents {
  final String id;
  final String name;
  final String date;
  final String time;
  final String description;

  Userevents({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.description,
  });
}

class UserViewEvents extends StatefulWidget {
  final bool showappbar;
  const UserViewEvents({super.key, required this.showappbar});

  @override
  _UserViewEventsState createState() => _UserViewEventsState();
}

class _UserViewEventsState extends State<UserViewEvents> {
  Future<List<Userevents>> getRequest() async {
    String url = "http://192.168.39.163/hopephp/event/view_event.php";

    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);

    List<Userevents> events = [];
    for (var singleEvent in responseData) {
      events.add(
        Userevents(
          id: singleEvent["Uid"].toString(),
          name: singleEvent["name"].toString(),
          date: singleEvent["date"].toString(),
          time: singleEvent["time"].toString(),
          description: singleEvent["description"].toString(),
        ),
      );
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
   // var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
     // backgroundColor: const Color(0xFFF6F5FF),
      appBar:widget.showappbar?   AppBar(
        centerTitle: true,
        title:Text(
          "Upcoming Events",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
       // backgroundColor: Colors.deepOrange,
      ) : null,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<Userevents>>(
          future: getRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Failed to load: ${snapshot.error}'));
            }
        
            final events = snapshot.data ?? [];
            if (events.isEmpty) {
              return const Center(child: Text('No events found.'));
            }
        
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Usereventdetails(event: event),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.deepOrange.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Event Icon
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.event,
                              color: Colors.deepOrange,
                              size: 35,
                            ),
                          ),
                          const SizedBox(width: 12),
        
                          // Event Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      event.date,
                                      style: GoogleFonts.nunito(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // const Icon(Icons.access_time,
                                    //     size: 14, color: Colors.grey),
                                    // const SizedBox(width: 4),
                                    // Text(event.time,
                                    //     style: GoogleFonts.nunito(
                                    //         fontSize: 13,
                                    //         color: Colors.grey[700])),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
        
                                    const SizedBox(width: 4),
                                    Text(
                                      event.time,
                                      style: GoogleFonts.nunito(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
        
                                // Text(
                                //   event.description,
                                //   maxLines: 2,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: GoogleFonts.nunito(
                                //       fontSize: 13, color: Colors.black87),
                                // ),
                              ],
                            ),
                          ),
        
                          // Details Button
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      Usereventdetails(event: event),
                                ),
                              );
                            },
                            child: Row(
                              children: const [
                                Text(
                                  "Details",
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.deepOrange,
                                ),
                              ],
                            ),
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
