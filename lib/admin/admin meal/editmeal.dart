import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:hopecart/admin/admin%20meal/meal%20class.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:hopecart/customfield.dart';
import 'package:hopecart/admin/admin%20meal/view%20meal%20items.dart';

class EditMeal extends StatefulWidget {
  final Mealclass mealData; // Pass existing meal data from previous page

  const EditMeal({super.key, required this.mealData});

  @override
  State<EditMeal> createState() => _EditMealState();
}

class _EditMealState extends State<EditMeal> {
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController price;
  late TextEditingController ingredients;

  String _selectedSize = "Small";
  final picker = ImagePicker();
  File? imageFile;
  String? existingImage;

  @override
  void initState() {
    super.initState();

    // ensure we convert non-string values to String
    name = TextEditingController(text: widget.mealData.name );
    description = TextEditingController(text: widget.mealData.description );
    price = TextEditingController(text: widget.mealData.price.toString());
    ingredients = TextEditingController(text: widget.mealData.ingredients );
    _selectedSize = widget.mealData.size ;
    existingImage = widget.mealData.image; // may be null
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Meal")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(imageFile!, fit: BoxFit.cover),
                      )
                    : (existingImage != null && existingImage!.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(existingImage!, fit: BoxFit.cover),
                          )
                        : const Center(child: Text("Tap to upload image")),
              ),
            ),
            const SizedBox(height: 20),

            customfield(
              controller: name,
              hinttext: 'Name',
              prefixicon: const Icon(Icons.fastfood),
              validator: (_) => null,
              obscuretext: false,
            ),
            const SizedBox(height: 12),

            customfield(
              controller: description,
              hinttext: 'Description',
              maxlines: 3,
              prefixicon: const Icon(Icons.description),
              validator: (_) => null,
              obscuretext: false,
            ),
            const SizedBox(height: 12),

            customfield(
              controller: price,
              hinttext: 'Price',
              keyboardtype: TextInputType.number,
              prefixicon: const Icon(Icons.attach_money),
              validator: (_) => null,
              obscuretext: false,
            ),
            const SizedBox(height: 12),

            customfield(
              controller: ingredients,
              hinttext: 'Ingredients',
              maxlines: 2,
              prefixicon: const Icon(CupertinoIcons.leaf_arrow_circlepath),
              validator: (_) => null,
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
              text: "Update Meal",
              onpressed: () async {
                await submitEditMeal();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked == null) {
        Fluttertoast.showToast(msg: 'No image selected');
        return;
      }
      setState(() => imageFile = File(picked.path));
    } catch (e) {
      Fluttertoast.showToast(msg: "Image pick failed: $e");
    }
  }

  Future submitEditMeal() async {
    // client-side validation (image optional)
    if (name.text.trim().isEmpty ||
        price.text.trim().isEmpty ||
        description.text.trim().isEmpty ||
        ingredients.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Missing required fields");
      return;
    }

    // ensure price is a positive integer before sending
    final intPrice = int.tryParse(price.text.trim());
    if (intPrice == null || intPrice <= 0) {
      Fluttertoast.showToast(msg: "Enter a valid price");
      return;
    }

    final uri = Uri.parse("http://192.168.172.163/hopephp/meal/editmeal.php");

    var request = http.MultipartRequest('POST', uri);

    // IMPORTANT: use proper Mealclass property access
    request.fields.addAll({
      'mealid': widget.mealData.mealid.toString(),
      'name': name.text.trim(),
      'price': intPrice.toString(),
      'description': description.text.trim(),
      'ingredients': ingredients.text.trim(),
      'size': _selectedSize,
    });

    if (imageFile != null) {
      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      request.files.add(pic);
    }

    try {
      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      // debug: always print response body to console
      print("EDIT MEAL - server response: ${response.body}");

      final body = jsonDecode(response.body);

      if (body['error'] == false) {
        Fluttertoast.showToast(msg: body['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Viewmealitems()),
        );
      } else {
        Fluttertoast.showToast(msg: body['message'] ?? "Update failed");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Update failed: $e");
      print("EditMeal exception: $e");
    }
  }
}
