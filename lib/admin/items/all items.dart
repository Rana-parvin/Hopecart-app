import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/viewcraft.dart';
import 'package:hopecart/admin/admin%20donation/admin_view_donation.dart';
import 'package:hopecart/admin/admin%20event/view_event.dart';
import 'package:hopecart/admin/admin%20meal/view%20meal%20items.dart';

class Allitems extends StatefulWidget {
  const Allitems({super.key});

  @override
  State<Allitems> createState() => _AllitemsState();
}

class _AllitemsState extends State<Allitems> {
 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HopeCart",style:GoogleFonts.petrona(fontWeight: FontWeight.bold),),
       
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
        view_craft(),
            view_events(),
    Viewmealitems(),
    Adminviewdonation(),
      ]),
      ),
    );
  }
}
