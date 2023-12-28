import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Imagepicker extends StatelessWidget {
  Imagepicker({super.key});
  File? file;
  String? url;

  var db = FirebaseFirestore.instance;

  void getgallary(String userId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);
      var imagename = basename(image.path);
      var storageRef = FirebaseStorage.instance.ref(imagename);
      await storageRef.putFile(file!);
      url = await storageRef.getDownloadURL();
      final images = <String, dynamic>{'image': url};
      await db.collection("users").doc(userId).set(images);
    }
  }

  // String? imageurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
                child: Container(
                  height: 60,
                  width: 70,
                  child: Image.asset('asset/image/gallery 1.png'),
                )),
          ),
          // Image.network(imageurl!),
        ],
      ),
    );
  }
}
