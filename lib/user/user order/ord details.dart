import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orddetails extends StatefulWidget {
  const Orddetails({super.key});

  @override
  State<Orddetails> createState() => _OrddetailsState();
}

class _OrddetailsState extends State<Orddetails> {
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Stack(
                      alignment: Alignment(1.5, -1.5),
                      children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 50,
                        ),
                        Icon(
                          Icons.restaurant_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 27,
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 20),
                  Text(
                    "Order Details",
                    style: GoogleFonts.radley(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                  ),
                 ],
                ),
                ),
        
            const SizedBox(height: 20),

           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                                      
               Center(
                 child: Container(
                    height: screenheight/1.5,width: screenwidth*0.85,
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column( crossAxisAlignment:CrossAxisAlignment.start ,
                   children: [
                                          //image
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(height: 200,width: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage("assets/images/meal.jpeg"),fit: BoxFit.cover)
                                      ),
                                    ),
                            ),
                          ),
                                            // order id
                       Column(
                         children: [
                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Order Id:#A12",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                 Text("₹ 450",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                                                  
                             ],
                           ),
                         ],
                       ),
                      SizedBox(height: 4,),
                          Text("Adam smith",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                             SizedBox(height: 4,),
                    
                           Text("01 Oct 12:30"),
                          SizedBox(height: 8,),
                          Row(children: [
                            Icon(Icons.circle,color: Colors.orange,size: 14,),
                            SizedBox(width: 6,),
                            Text("Pending",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                            )
                          ],),
                          Divider(height: 30,),
                 
                    SizedBox(height: 5,),
                     Text("Actions",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                     Center(child: Column(
                       children: [
                         ElevatedButton(onPressed: (){}, child: Text("Mark as completed")),
                           ElevatedButton(onPressed: (){}, child: Text("Mark as seen"))
           
                       ],
                     )),
                
                    ],),
                   ),
               ),
           
             ],
           ),
          
          ],
        ),
      ),
    );
  }
}
