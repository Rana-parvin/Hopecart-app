
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hopecart/admin/admin%20craft/editcraft.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/single%20class.dart';
import 'package:http/http.dart' as http;


//Creating a class user to store the data;
// class View_before_edit {
//   final String id;
//   final String craftid;
//   final String name;
//   final String price;
//   final String description;
//   final String image;

//   View_before_edit({
//     required this.id,
//     required this.craftid,
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.image,
//   });
// }

class edit_craft_view extends StatefulWidget {
  const edit_craft_view({super.key});

  @override
  _edit_craft_viewState createState() => _edit_craft_viewState();
}

class _edit_craft_viewState extends State<edit_craft_view> {

  Future<List<craftclass>> viewcrafts() async {
    String url = "http://192.168.172.163/hopephp/craft/viewcraft.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<craftclass> users = [];
    for (var singleUser in responseData) {
      craftclass user = craftclass(
        id:  singleUser["id"].toString(),
        craftid: singleUser["craftid"].toString(),
        name: singleUser["name"].toString(),
        price: singleUser["price"].toString(),
        description: singleUser["description"].toString(),
        image: singleUser["image"].toString(),
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
               CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Stack(
                    alignment: Alignment(2.8, -2.5),
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 40,
                      ),
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 23,
                      ),
                    ],
                  ),
                ),
                Text(
                  " Craft items",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Support a good cause",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 20),
              FutureBuilder(
                future: viewcrafts(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.data == null || snapshot.data == false) {
                    
                    return Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.red.shade900,
                              strokeWidth: 5,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Loading...",
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Flexible(
                      child: Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (ctx, index) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          child: Card(
                                            color:Colors.white,
                                            elevation: 8,
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),

                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  8.5,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  1.1,
                                              child: ListTile(
                                                contentPadding: EdgeInsets.all(15.0),
                                                leading: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.redAccent[200]
                                                
                                                  ),
                                                ),
                                              
                                                title: Text("Craft name:"+snapshot.data[index].name, overflow: TextOverflow.ellipsis,
                                                  style:
                                                  GoogleFonts.lora(fontSize: 15, color:Colors.deepOrangeAccent,fontWeight: FontWeight.bold),
                                                ),
                                                subtitle: Row(
                                                  children:[
                                                    Text("Craft price:"+snapshot.data[index].price,
                                                      overflow: TextOverflow.ellipsis,
                                                      style:
                                                      GoogleFonts.lora(fontSize: 15, color:Colors.deepOrangeAccent),
                                                    ),

                                                    SizedBox(width:15,),
                                                    Text("details",style: TextStyle(color: Colors.black),),
                                                    IconButton(onPressed: (){
                                                      Navigator.pushReplacement(context,
                                                          MaterialPageRoute(builder:
                                                              (context)=>Editcraft(edit: snapshot.data[index],)));
                                                    }, icon: Icon(Icons.arrow_forward_ios_rounded,color: Colors.lightGreenAccent.shade100,)),

                                                  ],  ),

                                              ),
                                            ),
                                          ),
                                         
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  //to delete the craft

  // Future<void> delrecord(String id) async {
  //   String url = "http://192.168.172.163/hopephp/craft/editcraft.php";
  //   var res = await http.post(Uri.parse(url), body: {
  //     "id": id,
  //   });
  //   var resoponse = jsonDecode(res.body);
  //   if (resoponse["success"] == "true") {
  //     print("success");
  //   }
  // }
}


