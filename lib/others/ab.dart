import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Caro extends StatefulWidget {
  const Caro({super.key});

  @override
  State<Caro> createState() => _CaroState();
}

class _CaroState extends State<Caro> {
  final List<String> _imagePaths = [
    'assets/images/abc1.jpg',
    'assets/images/ss.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
            ),
            items: _imagePaths.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          )
        ])));
  }
}