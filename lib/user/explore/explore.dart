import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/user/user%20craft/usercraftview.dart';
import 'package:hopecart/user/user%20donation/user%20view%20donation.dart';
import 'package:hopecart/user/user%20event/userviewevent.dart';
import 'package:hopecart/user/user%20meal/view%20items.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
      appBar: AppBar(
       // backgroundColor:const Color(0xFFF3F2FF),
        centerTitle: true,
        title: Text(
          "Explore...",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
       
        bottom: TabBar(
          //isScrollable: true,
        indicatorWeight: 3,
      //  automaticIndicatorColorAdjustment: false,
          indicatorColor: Colors.deepOrange,
          labelColor: Colors.deepOrange,
          unselectedLabelColor: Colors.grey[700],
          indicatorAnimation: TabIndicatorAnimation.elastic,
          indicatorSize: TabBarIndicatorSize.tab,
          tabAlignment: TabAlignment.center,
          dragStartBehavior: DragStartBehavior.start,
          tabs: [
           Tab(icon:Icon(Icons.brush),text: "Craft" ,),
           Tab(icon: Icon(Icons.event_outlined),text: "Events",),
           Tab(icon: Icon(Icons.local_restaurant_outlined),text: "Meals",),
                       Tab(icon: Icon(Icons.volunteer_activism),text: "Donations",),

        ],
        
        ),
      ),
      body: TabBarView(children:[
        Usercraftview(showappbar: false,),
            UserViewEvents(showappbar: false,),
    Viewitems(showappbar: false,),
    ViewDonation(showappbar: false,),
      ]),
      ),
    );
  }
}
