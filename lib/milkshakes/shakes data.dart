//model class for a milkshake item
import 'package:flutter/material.dart';

class Milkshakemodel {
  final String image;
  final String name;
  final String price;
  final Color color;

  Milkshakemodel({
    required this.image,
    required this.name,
    required this.price,
    required this.color,
  });
}

//Dummy data
final List<Milkshakemodel> milkshakes = [
  Milkshakemodel(image: "assets/images/banhoney2.png", name: "Banhoney", price: "12.00", color: Color(0xFFFF8C00)),

  Milkshakemodel(image: "assets/images/Strawmilk1.png", name: "Strawmilk", price: "11.00", color: Color(0xFFFF0000)),

  Milkshakemodel(image: "assets/images/chocoffee2.png", name: "Chocoffee", price: "15.00", color: Color(0xFF420E03)),

  Milkshakemodel(image: "assets/images/Cosmo berry1.png", name: "Cosmoberry", price: "10.00", color: Color(0xFF6116DA)),

   // Milkshakemodel(image: "assets/images/popcorn choco.jpg", name: "popcorn choco", price: "10.00", color: Color(0xFF6116DA))


];
