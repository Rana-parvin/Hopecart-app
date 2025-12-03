import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class mapwid extends StatefulWidget {
  const mapwid({super.key});

  @override
  State<mapwid> createState() => _mapwidState();
}

class _mapwidState extends State<mapwid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('openstreetmap'),),
    body: FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(12.8745, 75.3704 )
    ),
    children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",subdomains: ['a','b','c'],
        ),
    ],
    ),
    );
  }
}