import 'dart:convert';
import 'package:hopecart/admin/admin%20donation/admin%20donation%20details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Donation_details {
  // final String id;
  final String id;
  final String name;
  final String place;
  final String phone;
  final String amount;
  final String bank;
  final String account;

  Donation_details({
    // required this.id,
    required this.id,
    required this.name,
    required this.place,
    required this.phone,
    required this.amount,
    required this.bank,
    required this.account,
  });
}



class Adminviewdonation extends StatefulWidget {
  const Adminviewdonation({super.key});

  @override
  State<Adminviewdonation> createState() => _AdminviewdonationState();
}

class _AdminviewdonationState extends State<Adminviewdonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     //   appBar: AppBar( ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
      //        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Column(
                children: [
                  //  CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   radius: 60,
                  //   child: Stack(
                  //     alignment: Alignment(2.8, -2.5),
                  //     children: [
                  //       Icon(
                  //         Icons.monetization_on_rounded,
                  //         color: Theme.of(context).colorScheme.secondary,
                  //         size: 40,
                  //       ),
                  //       Icon(
                  //         Icons.add_circle,
                  //         color: Theme.of(context).colorScheme.secondary,
                  //         size: 23,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //  Text(
                  //   " Donations",
                  //   style: GoogleFonts.openSans(
                  //     fontSize: 30,
                  //     letterSpacing: 1,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // SizedBox(height: 5),
                  // Text(
                  //   "Support a good cause",
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w500,
                  //     letterSpacing: 1,
                  //   ),
                  // ),
            //      SizedBox(height: 20),
                  FutureBuilder(
                    future: getRequest(),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text('Loading...'),
                        ],
                      ),
                    );
                  }
                   if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load: ${snapshot.error}'),
                    );
                  }
                      final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return const Center(child: Text('No records found.'));
                  }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (ctx, index) => Column(
                            children: [
                              Padding(
                               padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10),),
                                  color: Colors.white,
                                  elevation: 5,
                                //  shadowColor: Colors.black,
                                                  
                                  child: Column(
                                    children: [
                                 ListTile(
                                   contentPadding: EdgeInsets.all(15.0,),
                                 //  textColor: Colors.white,
                                    leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    color: Colors.deepOrange,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: AssetImage('assets/images/craft1.avif')
                                    // ),
                                  ),
                                ),
                                title: Text(
                                  "${snapshot.data[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lora(
                                    fontSize: 15,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                  subtitle: Text(
                                      "price: ${snapshot.data[index].amount}",
                                      overflow:
                                          TextOverflow.ellipsis,
                                      style: GoogleFonts.lora(
                                        fontSize: 15,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                    trailing: TextButton.icon(
                                 onPressed: () {
                                   Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) =>
                                           donationdetails(
                                             donate: snapshot
                                                 .data[index],
                                           ),
                                     ),
                                   );
                                 },label: Text("Details",style: TextStyle(color: Colors.black),),
                                 icon: Icon(
                                   Icons
                                       .arrow_forward_ios_rounded,
                                   color: Colors
                                       .lightGreenAccent
                                       .shade100,
                                 ),
                                 iconAlignment: IconAlignment.end,
                               ),        
                                   ),
                             
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

   Future<List<Donation_details>> getRequest() async {
    //replace your restFull API here.
    String url = "http://192.168.172.163/hopephp/moneydonation/viewdonation.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    List<Donation_details> users = [];
    for (var singleUser in responseData) {
      Donation_details user = Donation_details(
        id: singleUser["id"].toString(),
        name: singleUser["name"].toString(),
        place: singleUser["place"].toString(),
        phone: singleUser["phone"].toString(),
        amount: singleUser["amount"].toString(),
        bank: singleUser["bank"].toString(),
        account: singleUser["account"].toString(),
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }
}