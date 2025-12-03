import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartRemoval {
  static Future<bool> delrecord(String id) async {
    const String url = "http://192.168.39.163/hopephp/cart/deletecart.php";
    try {
      final res = await http.post(Uri.parse(url), body: {"cartid": id}).timeout(const Duration(seconds: 15));
      debugPrint('delrecord: status=${res.statusCode} body=${res.body}');
      if (res.statusCode != 200) return false;
      final Map<String, dynamic> body = jsonDecode(res.body);
      if (body['success'] == true || body['success'] == 'true' || body['success'] == 'Successfully Deleted') {
        return true;
      }
      return false;
    } catch (e, st) {
      debugPrint('delrecord error: $e\n$st');
      return false;
    }
  }
}
