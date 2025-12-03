import 'dart:ui';
import 'package:hopecart/milkshakes/shakes%20data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Milkshakepage extends StatefulWidget {
  const Milkshakepage({super.key});

  @override
  State<Milkshakepage> createState() => _MilkshakepageState();
}

class _MilkshakepageState extends State<Milkshakepage> {
  final PageController _pagecontroller = PageController(
    viewportFraction: 0.5,
    initialPage: 500,          //i have changed 1000 to 500
  );

  final PageController _priceslidecontroller = PageController();

  int currentpage = 0;

  //handle when milkshake changes
  void onchangepage(int page) {
    setState(() {
      currentpage = page % milkshakes.length;
    });

    //animate the price widget to match the milkshake
    _priceslidecontroller.animateToPage(
      page % milkshakes.length,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    //initial jump for demo purpose
    Future.delayed(const Duration(milliseconds: 100), () {
      _pagecontroller.animateToPage(
        1001,                                 //1001 here
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
    _priceslidecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background gradient
          Milkshakebg(color: milkshakes[currentpage].color),

          //main content
          ListView(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 700,
              child: Stack(
                children: [
                //promo card (half circle)
                Positioned(top: 50,left: 0,right: 0,
                  child: Promocard(color: milkshakes[currentpage].color,
                ),
                ),
                Positioned(top: 30,
                  child: MilkshakeSlider(pageController: _pagecontroller, 
                currentpage: currentpage, onpagechanged:onchangepage ))
              ],),
            ),
          
            //price widget
            Pricewidget(color: milkshakes[currentpage].color, priceslidecontroller: _priceslidecontroller)
          ],)
        ],
      ),
    );
  }
}

//background with gradient animation
class Milkshakebg extends StatelessWidget {
  final Color color;
  const Milkshakebg({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white,  //top
           color.withOpacity(0.4),  //middle
            Colors.white    //bottom
            ],
        ),
      ),
    );
  }
}

   //promo card with custom clipped half  circle shape
class Promocard extends StatelessWidget {
  final Color color;
  const Promocard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ClipPath(
        clipper:TopHalfCircleClipper(),
        child: AnimatedContainer(duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width /1.4,height: 300,
        decoration:BoxDecoration(
          gradient: LinearGradient(
            begin:Alignment .topCenter,
            end: Alignment.bottomCenter,
            colors: [
            color.withOpacity(0.3), 
            color
          ])
        ) ,
        child: Column(
          children: [
            const SizedBox(height: 40,),

            //small star svg
            SvgPicture.asset("assets/images/star.svg", width: 20,
            
            colorFilter:const ColorFilter.mode(Colors.white,BlendMode.srcIn),
            ),
            const SizedBox(height: 8,),

            //promo text
            const SizedBox(height: 5,),
            Text("Only This",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
            const SizedBox(height: 5,),
            Text("Weekend",style: GoogleFonts.greatVibes(fontSize: 60,color: Colors.white,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
            ),)
          ],
        ),
        ),
      ),
    );
  }
}



  
   //milkshake slider with looping support
class MilkshakeSlider extends StatelessWidget {
  final PageController pageController;
  final int currentpage;
  final ValueChanged<int> onpagechanged;
  const MilkshakeSlider({super.key, required this.pageController, required this.currentpage, required this.onpagechanged});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: AnimatedBuilder(animation: pageController, builder: (context,child){
        return PageView.builder(
          padEnds: false,
          controller: pageController,
          onPageChanged: onpagechanged,
          //infinite loop effect using modulo
          itemBuilder: (context,index){
            final actualindex=index % milkshakes.length;

            double value=0.0;
            if(pageController.position.haveDimensions){
              value=index.toDouble() -(pageController.page ?? 0);
              value=(value * 0.7).clamp(-1, 1);
            }
            return GestureDetector(
              onTap: () {
                pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
              },
              child: ImageFiltered(imageFilter: ImageFilter.blur(
                sigmaX: currentpage==actualindex ? 0 : 3,
                sigmaY: currentpage==actualindex ? 0 : 3,
              ),
              child: Align(alignment: Alignment.center,
              child: Transform.translate(offset: Offset(0,( value.abs() * -100)),
              child: Transform.scale(
                scale: 1-(value.abs() * 0.6),
                child: Column(children: [
                  Image.asset(milkshakes[actualindex].image,
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                 fit: BoxFit.contain, 
                  
                  ),
                  const SizedBox(height: 5,),
                  Text(milkshakes[actualindex].name,
                  textAlign: TextAlign.center,
                  maxLines: 2,overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(fontSize: 28,fontWeight: FontWeight.bold,color: milkshakes[actualindex].color),)
                ],),
              ),
              ),
              
              ),
              ),
            );
          });
      }),
    );
  }
}


//price widget with vertical page view
class Pricewidget extends StatelessWidget {
  final Color color;
  final PageController priceslidecontroller;
  const Pricewidget({super.key, required this.color, required this.priceslidecontroller});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        //price divider with stars
        SizedBox(width: MediaQuery.of(context).size.width,
        child: Row(children: [
          Expanded(child: Divider(color: color,)),
          //star image
          SvgPicture.asset("assets/images/star.svg",width: 18,colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          Expanded(child: Divider(color: color,)),

          //price container with vertical sliding
          Container(height: 40,width: 170,
          decoration:BoxDecoration(
            border: Border.all(color: color,width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            
          ) ,
          child: PageView.builder(
            itemCount: milkshakes.length,
            controller: priceslidecontroller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Center(
                child: Text("\$${milkshakes[index].price} EACH", style: GoogleFonts.montserrat(fontSize: 21,color: color,fontWeight: FontWeight.w800),),
              );
            }
            ),
          ),
          Expanded(child: Divider(color: color,)),
          SvgPicture.asset("assets/images/star.svg",width: 18,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          Expanded(child: Divider(color: color,))
        ],
        ),
        ),
        const SizedBox(height: 8,),

        //offer text
        Center(child: Text("BUY 1 GET 1 FREE", style: GoogleFonts.montserrat(fontSize: 12,color: color,fontWeight: FontWeight.w600),),)
      ],
    );
  }
}


class TopHalfCircleClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size ){
    final path=Path();

    //start from bottom left
    path.moveTo(0, size.height);

    //go up left side
    path.lineTo(0, size.height /2);

    //draw half circle arc accross top
    path.arcToPoint(
      Offset(size.width, size.height /2),
      radius:  Radius.circular(size.width /2));


    //go down right side
    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>false;
    
}
