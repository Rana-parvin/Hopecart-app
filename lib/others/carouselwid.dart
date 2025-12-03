import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carouselwid extends StatefulWidget {
  const Carouselwid({super.key});

  @override
  State<Carouselwid> createState() => _CarouselwidState();
}

class _CarouselwidState extends State<Carouselwid> {
  final List<String> imagepaths = [
    'assets/images/cartoon.jpg',
    'assets/images/hopes.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
                items: imagepaths.map((image) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                         width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(  
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(image,fit: BoxFit.cover,),
                    ),
                    );
                     
                  });
                }).toList(),
                options: CarouselOptions(
                   height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              scrollDirection: Axis.horizontal,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              
                )
                
        )],
        ),
      ),
    );
  }
}
