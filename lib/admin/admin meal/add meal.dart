import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20meal/view%20meal%20items.dart';
import 'package:hopecart/button/formbutton.dart';
import 'package:hopecart/customfield.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Addmeal extends StatefulWidget {
  const Addmeal({super.key});

  @override
  State<Addmeal> createState() => _AddmealState();
}

class _AddmealState extends State<Addmeal> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController ingredients = TextEditingController();

  String _selectedSize = "Small";
  final picker = ImagePicker();
  File? imageFile;



  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickimage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageFile == null
                    ? const Center(child: Text("Tap to upload image"))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(imageFile!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            customfield(
              controller: name,
              hinttext: 'Name',
              prefixicon: Icon(Icons.fastfood),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter meal name';
                }
                return null;
              },
              obscuretext: false,
            ),
            const SizedBox(height: 12),

            customfield(
              maxlines: 3,
              controller: description,
              hinttext: 'Description',
              prefixicon: Icon(Icons.description),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
              obscuretext: false,
            ),

            const SizedBox(height: 12),

            customfield(
              controller: price,
              keyboardtype: TextInputType.number,
              hinttext: 'Price',
              prefixicon: Icon(Icons.attach_money),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter price';
                }
                return null;
              },
              obscuretext: false,
            ),
            const SizedBox(height: 12),

            customfield(
              controller: ingredients,
              maxlines: 2,
              hinttext: 'Ingredients',
              prefixicon: Icon(CupertinoIcons.leaf_arrow_circlepath),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the ingredients used in this meal";
                }
                return null;
              },
              obscuretext: false,
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField(
              initialValue: _selectedSize,
              items: const [
                DropdownMenuItem(value: "Small", child: Text("Small")),
                DropdownMenuItem(value: "Medium", child: Text("Medium")),
                DropdownMenuItem(value: "Large", child: Text("Large")),
              ],
              onChanged: (value) {
                setState(() => _selectedSize = value.toString());
              },
              decoration: const InputDecoration(labelText: "Size"),
            ),
            const SizedBox(height: 20),

            formbutton(
              height: screenheight / 20,
              width: screenwidth * 0.7,
              text: "Add Meal",

              onpressed: () async {
                await submitMeal();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future pickimage() async {
    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked == null) {
        Fluttertoast.showToast(msg: 'No image selected');
        return;
      }
      setState(() => imageFile = File(picked.path));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future submitMeal() async {
    if (name.text.isEmpty ||
        description.text.isEmpty ||
        price.text.isEmpty ||
        ingredients.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }
    if (imageFile == null) {
      Fluttertoast.showToast(msg: 'Please select an image');
      return;
    }

    final namec = name.text.trim();
    final pricec = price.text.trim();
    final descriptionc = description.text.trim();
    final ingredientsc = ingredients.text.trim();

    final uri = Uri.parse(
      "http://192.168.172.163/hopephp/meal/adminaddfood.php",
    );

    var request = http.MultipartRequest('POST', uri);

    request.fields.addAll({
      'name': namec,
      'price': pricec,
      'description': descriptionc,
      'ingredients': ingredientsc,
      'size': _selectedSize,
     // 'createdat': DateTime.now().toString(),    //useless
    });
    try {
      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      request.files.add(pic);

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      print("Server response: ${response.body}");
      try {
        final body = jsonDecode(response.body);

        if (body['error'] == false) {
          Fluttertoast.showToast(msg: body['message']);
          name.clear();
          price.clear();
          description.clear();
          ingredients.clear();
          setState(() => imageFile = null);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Viewmealitems()),
          );
        } else {
          Fluttertoast.showToast(msg: body['message']);
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Server returned invalid response");
      }
    } catch (e) {
      print("Upload error: $e");
      Fluttertoast.showToast(msg: "Upload failed");
    }

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(const SnackBar(content: Text("Meal submitted")));
  }
}
