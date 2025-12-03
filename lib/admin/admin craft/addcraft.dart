import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/viewcraft.dart';
import 'package:hopecart/customfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Addcraft extends StatefulWidget {
  const Addcraft({super.key});

  @override
  State<Addcraft> createState() => _AddcraftState();
}

class _AddcraftState extends State<Addcraft> {
  File? image;
  final picker = ImagePicker();

  final craftidc = TextEditingController();
  final namec = TextEditingController();
  final pricec = TextEditingController();
  final descriptionc = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    craftidc.dispose();
    namec.dispose();
    pricec.dispose();
    descriptionc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Stack(
                    alignment: const Alignment(2.8, -2.5),
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 40,
                      ),
                      Icon(
                        Icons.add_circle,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 23,
                      ),
                    ],
                  ),
                ),
                Text(
                  " Add item",
                  style: GoogleFonts.openSans(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Support a good cause",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),

                customfield(
                  hinttext: "Craft id",
                  controller: craftidc,
                  keyboardtype: const TextInputType.numberWithOptions(),
                  prefixicon: const Icon(Icons.badge),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please give an id";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),

                customfield(
                  hinttext: "Item name",
                  controller: namec,
                  prefixicon: const Icon(Icons.edit),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Give the name of the item";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),

                customfield(
                  keyboardtype: const TextInputType.numberWithOptions(),
                  hinttext: "Price",
                  controller: pricec,
                  prefixicon: const Icon(Icons.monetization_on),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the price";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),

                customfield(
                  hinttext: "Description",
                  controller: descriptionc,
                  prefixicon: const Icon(Icons.description),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
                  obscuretext: false,
                ),

                const SizedBox(height: 10),

                // IMAGE PICKER
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text("Choose from gallery"),
                                onTap: () async {
                                  Navigator.pop(context);
                                  await chooseImageGallery();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text("Choose from camera"),
                                onTap: () async {
                                  Navigator.pop(context);
                                  await chooseImageCamera();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 120,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(image!, fit: BoxFit.cover),
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.upload),
                                  Expanded(
                                    child: Text(
                                      "Upload image",
                                      style: GoogleFonts.patuaOne(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                formbutton(
                  height: screensize / 20,
                  width: screenwidth / 1.5,
                  text: 'Add Craft',
                  onpressed: () async {
                    if (formkey.currentState!.validate()) {
                      await addItem();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // IMAGE PICK FROM GALLERY
  Future chooseImageGallery() async {
    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked == null) {
        Fluttertoast.showToast(msg: 'No image selected');
        return;
      }
      setState(() => image = File(picked.path));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // IMAGE PICK FROM CAMERA
  Future chooseImageCamera() async {
    try {
      final picked = await picker.pickImage(source: ImageSource.camera);
      if (picked == null) {
        Fluttertoast.showToast(msg: 'No image selected');
        return;
      }
      setState(() => image = File(picked.path));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // ADD ITEM FUNCTION
  Future addItem() async {
    if (image == null) {
      Fluttertoast.showToast(msg: 'Please select an image');
      return;
    }

    final craftId = craftidc.text.trim();
    final name = namec.text.trim();
    final price = pricec.text.trim();
    final description = descriptionc.text.trim();

    final uri = Uri.parse("http://192.168.172.163/hopephp/craft/addcraft.php");

    var request = http.MultipartRequest('POST', uri);

    request.fields.addAll({
      'craftid': craftId,
      'name': name,
      'price': price,
      'description': description,
    });

    try {
      var pic = await http.MultipartFile.fromPath("image", image!.path);
      request.files.add(pic);

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      print("Server response: ${response.body}");

      try {
        final body = jsonDecode(response.body);

        if (body['error'] == false) {
          Fluttertoast.showToast(msg: body['message']);
          craftidc.clear();
          namec.clear();
          pricec.clear();
          descriptionc.clear();
          setState(() => image = null);
        } else {
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text("Craft added successfully")));
          Fluttertoast.showToast(msg: body['message']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => view_craft()),
          );
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Server returned invalid response");
      }
    } catch (e) {
      print("Upload error: $e");
      Fluttertoast.showToast(msg: "Upload failed");
    }
  }
}

// BUTTON WIDGET
class formbutton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final dynamic Function() onpressed;

  const formbutton({
    super.key,
    required this.height,
    required this.text,
    required this.width,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onpressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
