import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin craft/viewcraft.dart';
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
  bool isLoading = false;

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
      body: Stack(
        children: [
          // TOP DESIGN HEADER
          Container(
            height: screensize * 0.30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),

          // CONTENT
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add New Craft",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Every craft supports kindness",
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // PICK IMAGE CARD
                    GestureDetector(
                      onTap: selectImageOption,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload, size: 40, color: Theme.of(context).colorScheme.secondary),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Upload Image",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.file(image!, fit: BoxFit.cover),
                              ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // FORM CARD
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          customfield(
                            hinttext: "Craft ID",
                            controller: craftidc,
                            keyboardtype: const TextInputType.numberWithOptions(),
                            prefixicon: const Icon(Icons.badge),
                            validator: (value) => value!.isEmpty ? "Required" : null,
                            obscuretext: false,
                          ),
                          customfield(
                            hinttext: "Item Name",
                            controller: namec,
                            prefixicon: const Icon(Icons.edit),
                            validator: (value) => value!.isEmpty ? "Required" : null,
                            obscuretext: false,
                          ),
                          customfield(
                            keyboardtype: const TextInputType.numberWithOptions(),
                            hinttext: "Price",
                            controller: pricec,
                            prefixicon: const Icon(Icons.monetization_on),
                            validator: (value) => value!.isEmpty ? "Required" : null,
                            obscuretext: false,
                          ),
                          customfield(
                            hinttext: "Description",
                            controller: descriptionc,
                            prefixicon: const Icon(Icons.description),
                            validator: (value) => value!.isEmpty ? "Required" : null,
                            obscuretext: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // SUBMIT BUTTON
                    SizedBox(
                      height: 55,
                      width: screenwidth / 1.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 10,
                        ),
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (formkey.currentState!.validate()) {
                                  await addItem();
                                }
                              },
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Add Craft",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // IMAGE OPTION POPUP
  void selectImageOption() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Choose from Gallery"),
            onTap: () async {
              Navigator.pop(context);
              await chooseImageGallery();
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Open Camera"),
            onTap: () async {
              Navigator.pop(context);
              await chooseImageCamera();
            },
          ),
        ],
      ),
    );
  }

  Future chooseImageGallery() async {
    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) setState(() => image = File(picked.path));
    } on PlatformException catch (e) {
      print("Gallery Error: $e");
    }
  }

  Future chooseImageCamera() async {
    try {
      final picked = await picker.pickImage(source: ImageSource.camera);
      if (picked != null) setState(() => image = File(picked.path));
    } on PlatformException catch (e) {
      print("Camera Error: $e");
    }
  }

  Future addItem() async {
    if (image == null) {
      Fluttertoast.showToast(msg: "Image required");
      return;
    }

    setState(() => isLoading = true);

    final uri = Uri.parse("http://192.168.39.163/hopephp/craft/addcraft.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields.addAll({
      'craftid': craftidc.text.trim(),
      'name': namec.text.trim(),
      'price': pricec.text.trim(),
      'description': descriptionc.text.trim(),
    });

    var pic = await http.MultipartFile.fromPath("image", image!.path);
    request.files.add(pic);

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    final body = jsonDecode(response.body);
    setState(() => isLoading = false);

    Fluttertoast.showToast(msg: body['message']);

    if (body['error'] == false) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => view_craft()));
    }
  }
}
