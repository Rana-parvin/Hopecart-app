
import 'package:flutter/material.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20event/common%20class.dart';
import 'package:hopecart/admin/admin%20event/editevent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/button/formbutton.dart';


class a_event_details extends StatefulWidget {


  final Eventclass events;

  const a_event_details({super.key, required this.events});
  // const craft_details({Key? key}) : super(key: key);
  @override
  _a_event_detailsState createState() => _a_event_detailsState();
}

class _a_event_detailsState extends State<a_event_details> {
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenheight=MediaQuery.of(context).size.height;
    var screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
          margin: const EdgeInsets.all(20),
           
            child: Column(
              children: [

                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Stack(
                      alignment: Alignment(2.8, -2.5),
                      children: [
                        Icon(
                          Icons.event,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 40,
                        ),
                        Icon(
                          Icons.description,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 23,
                        ),
                      ],
                    ),
                  ),
                     const      SizedBox(height: 5),
                      
                    Text(
                          " Details",
                          style: GoogleFonts.openSans(
                            fontSize: 30,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const   SizedBox(height: 5),
                        Text(
                          "Support a good cause",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      const  SizedBox(height: 20),
                 Center(
                          child: Text(widget.events.name, style: GoogleFonts.taiHeritagePro(
                               fontSize: 20, color: Colors.green.shade900)),
                        ),
                        const SizedBox(height: 20,),

                        Row(
                  children: [
                    Text("On :",
                      style: GoogleFonts.adamina(fontSize: 20, color: Colors.black),),
                    SizedBox(width: 10,),
                    Text(widget.events.date, style: GoogleFonts.taiHeritagePro(
                        fontSize: 20, color: Colors.green.shade900))
                  ], 
                ),
              const  SizedBox(height:5,),
                Row(
                  children: [
                    Text("At :",
                      style: GoogleFonts.adamina(fontSize: 20, color: Colors.black),),
                    SizedBox(width: 10,),
                    Text(widget.events.time, style: GoogleFonts.taiHeritagePro(
                        fontSize: 20, color: Colors.green.shade900))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 194, 176, 225),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 180,
                    width: 230,
                    child: Image.asset(
                      "image",
                      fit: BoxFit.fill,
                    ),

                    //  child:Image.network(widget.data_user.image,fit: BoxFit.cover,)
                  ),
                ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 15,
                          bottom: 7,
                        ),
                        child: Container(
                                height: screenheight * 0.2,
                            width: screenwidth * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 15,
                          bottom: 7,
                        ),
                        child: Text(
                          "Description:",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 15,
                          top: 7,
                        ),
                        child: Text("${widget.events.description}"),
                      ),
                    ],
                  ),
                ),
                      ),
                    
                    ],
                  ),
                
             const   SizedBox(height: 20,),
                
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    formbutton(
                      height: 50,
                      width: screenwidth * 0.42,
                      text: "Edit ",
                      onpressed: () async{
                        await edit_event(edit: Eventclass(id: widget.events.id, time: widget.events.time,
                         name: widget.events.name,  description: widget.events.description, date: widget.events.date));
                      },
                    ),
                    formbutton(
                      height: 50,
                      width: screenwidth * 0.42,
                      text: "Done",
                      onpressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                  const SizedBox(height: 20,)  
                
              ],
            ),
          ),
        ),
      ),
    );
  }
 
  }


