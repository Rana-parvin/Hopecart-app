import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/user/user craft/usercraftdetails.dart';
import 'package:http/http.dart' as http;

class Usercrafts {
  final String id;
  final String craftid;
  final String name;
  final String price;
  final String description;
  final String image;

  Usercrafts({
    required this.id,
    required this.craftid,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });
}

class Usercraftview extends StatefulWidget {
  final bool showappbar;
  const Usercraftview({super.key, required this.showappbar});

  @override
  State<Usercraftview> createState() => _UsercraftviewState();
}

class _UsercraftviewState extends State<Usercraftview> {
  late Future<List<Usercrafts>> _craftsFuture;

  @override
  void initState() {
    super.initState();
    _craftsFuture = getRequest();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:widget.showappbar ?   AppBar(
        title: Text(
          "Craft Items",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
      //  backgroundColor: Colors.deepOrange,
       elevation: 0,
      )  : null,
    //  backgroundColor: const Color(0xFFF3F2FF),
      body: FutureBuilder<List<Usercrafts>>(
        future: _craftsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text("No crafts found."));
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Usercraftdetails(item: item),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // IMAGE
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: item.image.isNotEmpty
                              ? Image.network(
                                  item.image,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/meal.jpeg",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),

                        const SizedBox(height: 10),

                        // NAME
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),

                        // PRICE
                        Text(
                          "₹${item.price}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // DESCRIPTION (optional truncated)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            item.description,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<List<Usercrafts>> getRequest() async {
    String url = "http://192.168.39.163/hopephp/craft/viewcraft.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception("Failed to load crafts: ${response.statusCode}");
    }

    var responseData = json.decode(response.body);
    List<Usercrafts> crafts = [];
    for (var item in responseData) {
      crafts.add(
        Usercrafts(
          id: item["craftid1"].toString(),
          craftid: item["craftid"].toString(),
          name: item["name"].toString(),
          price: item["price"].toString(),
          description: item["description"].toString(),
          image: item["image"].toString(),
        ),
      );
    }
    return crafts;
  }
}
