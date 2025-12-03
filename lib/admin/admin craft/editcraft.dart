import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopecart/admin/admin%20craft/addcraft.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/admin/admin%20craft/single%20class.dart';
import 'package:hopecart/customfield.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Editcraft extends StatefulWidget {
  final craftclass edit;

  const Editcraft({super.key, required this.edit});

  @override
  _EditcraftState createState() => _EditcraftState();
}

class _EditcraftState extends State<Editcraft> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _craftid = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  late bool status;

  late String message;

  // File? get filePath => null;

  @override
  void initState() {
    _craftid = TextEditingController(text: widget.edit.craftid);
    _name = TextEditingController(text: widget.edit.name);
    _price = TextEditingController(text: widget.edit.price);
    _description = TextEditingController(text: widget.edit.description);

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future choose_image_gallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future choose_image_camera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60,
              child: Stack(
                alignment: Alignment(2.4, 2.2),
                children: [
                  Icon(
                    Icons.card_giftcard,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 45,
                  ),
                  Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 25,
                  ),
                ],
              ),
            ),
            Text(
              " Edit product",
              style: GoogleFonts.openSans(
                fontSize: 30,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Support a good cause",
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(30),
              width: double.infinity,
              // height: MediaQuery.of(context).size.height,
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Center(
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          splashColor: Colors.blueGrey,
                          onTap: () {
                            showModalBottomSheet(
                              sheetAnimationStyle: AnimationStyle(
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                              ),
                              context: context,
                              builder: (context) {
                                return ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.photo),
                                      title: Text("Choose from gallery"),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await choose_image_gallery();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera),
                                      title: Text("Choose from camera"),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await choose_image_camera();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              height: 140,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.orange),
                              ),
                              child: _image != null
                                  ? Image.file(_image!, fit: BoxFit.cover)
                                  : Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.upload_rounded,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "Upload image",
                                            style: GoogleFonts.patuaOne(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    customfield(
                      hinttext: 'Product name',
                      prefixicon: Icon(Icons.edit),
                      controller: _name,
                      keyboardtype: TextInputType.text,
                      validator: (value) {
                        if (value==null||  value.isEmpty) {
                          return "Please enter a product name";
                        }
                        return null;
                      },
                      obscuretext: false,
                    ),
                    //   const SizedBox(height: 20),
                    customfield(
                      hinttext: 'Price',
                      controller: _price,
                      prefixicon: Icon(Icons.monetization_on_rounded),

                      keyboardtype: TextInputType.number,
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return "Please enter Price";
                        }
                        return null;
                      },
                      obscuretext: false,
                    ),
                    //   const SizedBox(height: 20),
                    customfield(
                      hinttext: "Description",
                      controller: _description,
                      prefixicon: Icon(Icons.description),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a brief description";
                        }
                        return null;
                      },
                      obscuretext: false,
                    ),

                    //   const SizedBox(height: 30),
                    const SizedBox(height: 20),
                    formbutton(
                      height: screenheight / 17,
                      width: screenwidth / 1.1,
                      text: 'Update Details',
                      onpressed: () async {
                        if (formkey.currentState!.validate()) {
                          await Update();
                        }
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),

                //],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future Update() async {
    final uri = Uri.parse(
      "http://192.168.172.163/hopephp/craft/editcraft.php",
    );
    try {
      var request = http.MultipartRequest('POST', uri);
      request.fields['craftid1'] = widget.edit.id.toString();
      request.fields['price'] = _price.text;
      request.fields['craftid'] = _craftid.text;
      request.fields['name'] = _name.text;
      request.fields['description'] = _description.text;

      if (_image != null) {
        final pic = await http.MultipartFile.fromPath("image", _image!.path);
        request.files.add(pic);
      }
      var streamedresponse = await request.send().timeout(
        const Duration(seconds: 60),
      );
      final response = await http.Response.fromStream(streamedresponse);
      debugPrint('Update: HTTP ${response.statusCode}');
      debugPrint('Update: body: ${response.body}');

      if (response.statusCode == 200) {
       // Optionally parse response.body if your PHP returns JSON and check success flag
        setState(() {
          _image = null;
        });

        _price.clear();
        _name.clear();
        _craftid.clear();
        _description.clear();

        Fluttertoast.showToast(
        msg: 'Item Updated Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );
      } else {
        debugPrint('Update failed: ${response.statusCode} ${response.body}');
       Fluttertoast.showToast(
        msg: 'Update failed: ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );    }
    } on SocketException catch (e) {
      debugPrint('Update SocketException: $e');

     Fluttertoast.showToast(
        msg: 'Network unreachable  ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );

    } on TimeoutException catch (e) {
      debugPrint('Update Timeout: $e');
      Fluttertoast.showToast(
        msg: 'Request timed out',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );
    } catch (e, st) {
      debugPrint('Update error: $e\n$st');
      Fluttertoast.showToast(
        msg: 'Unexpected error during update',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );
    }
  }
}
