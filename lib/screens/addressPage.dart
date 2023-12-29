import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:path/path.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/user.dart' as model;
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  bool _isUploading = false;
  String? name;
  String? phone;
  String? address;

  @override
  Widget build(BuildContext context) {
    model.User? loggedInUser = Provider.of<UserProvider>(context).loggedInUser;
    GlobalKey<FormState> key = GlobalKey();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontFamily: fontFamilyString,
          ),
        ),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _pickAndUploadImage(
                        context,
                        loggedInUser,
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border(
                          left: BorderSide(
                            color: buttonColor,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: _buildProfileImage(loggedInUser),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  fieldContainer(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Field is Empty';
                        }
                      },
                      label: 'Name',
                      prefixIconPath: 'asset/images/user.png',
                      hintText: loggedInUser!.fullName,
                      onChanged: (data) {
                        name = data;
                      }),
                  fieldContainer(
                    label: 'Phone number',
                    prefixIconPath: 'asset/images/call.png',
                    hintText: loggedInUser.phoneNumber,
                    maxLength: 11,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Field is Empty';
                      } else if (data.length < 10) {
                        return 'Mobile number is too short';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(data)) {
                        return 'Invalid characters in the mobile number';
                      }
                    },
                    onChanged: (data) {
                      phone = data;
                    },
                    textInputType: TextInputType.phone,
                  ),
                  fieldContainer(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Field is Empty';
                        }
                      },
                      label: 'Address',
                      prefixIconPath: 'asset/images/addressicon.png',
                      hintText: loggedInUser.address,
                      onChanged: (data) {
                        address = data;
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    text: 'Save',
                    onTap: () {
                      if (key.currentState!.validate()) {
                        updateUserData(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(model.User? loggedinUser) {
    return _isUploading
        ? const CircularProgressIndicator(
            color: buttonColor,
          )
        : CachedNetworkImage(
            imageUrl: loggedinUser!.profileImage,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider,
              child: const Icon(
                Icons.camera_alt,
                color: Colors.black45,
              ),
              // ,
            ),
            placeholder: (context, url) => const CircularProgressIndicator(
              color: buttonColor,
            ),
            errorWidget: (context, url, error) {
              return CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('asset/images/profile.png'),
                child: const Icon(
                  Icons.add_a_photo,
                  color: fontSecondaryColor,
                ),
              );
            },
          );
  }

  Future<void> _pickAndUploadImage(
      BuildContext context, model.User? user) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      String imageName = basename(image.path);

      setState(() {
        _isUploading = true; // Set loading to true when starting the upload
      });

      try {
        // Upload the image to Firebase Storage
        Reference storageRef =
            FirebaseStorage.instance.ref('profile_images/$imageName');
        await storageRef.putFile(file);

        // Get the download URL of the uploaded image
        String imageUrl = await storageRef.getDownloadURL();

        // Update the user's document in Firestore with the image URL
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'image': imageUrl});

        // Update the UserProvider with the new image URL
        user.profileImage = imageUrl;

        // Notify listeners to trigger a rebuild
        Provider.of<UserProvider>(context, listen: false).notifyListeners();
      } catch (error) {
        // Handle errors (e.g., show an error message)
        print('Error uploading image: $error');
      } finally {
        setState(() {
          _isUploading =
              false; // Set loading to false when upload is complete (or fails)
        });
      }
    }
  }

  updateUserData(BuildContext context) async {
    model.User? loggedInUser =
        Provider.of<UserProvider>(context, listen: false).loggedInUser;

    if (loggedInUser != null) {
      try {
        Map<String, dynamic> updatedData = {};

        // Check if name is provided and different from the current name
        if (name != null && name != loggedInUser.fullName) {
          updatedData['fullName'] = name;
        }

        // Check if phone is provided and different from the current phone
        if (phone != null && phone != loggedInUser.phoneNumber) {
          updatedData['phoneNumber'] = phone;
        }

        // Check if address is provided and different from the current address
        if (address != null && address != loggedInUser.address) {
          updatedData['address'] = address;
        }

        // Update the user's document in Firestore
        if (updatedData.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(loggedInUser.uid)
              .update(updatedData);

          // Update the UserProvider with the new data
          Provider.of<UserProvider>(context, listen: false).updateUserData(
              fullName: name, phoneNumber: phone, address: address);
          context.showCustomSnackBar(
            message: 'Updated Successfully',
            color: Colors.green,
          );
        }

        // Notify listeners to trigger a rebuild
        Provider.of<UserProvider>(context, listen: false).notifyListeners();
      } catch (error) {
        print('Error updating user data: $error');
      }
    }
  }

  Widget fieldContainer({
    required String label,
    required String prefixIconPath,
    required String? hintText,
    Function(String)? onChanged,
    int maxLength = 25,
    TextInputType? textInputType,
    String? Function(String?)? validator, // Validator function
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: fontFamilyString,
                color: fontSecondaryColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        CustomTextFeild2(
          validator: validator,
          maxLenght: maxLength,
          obscureText: false,
          prefiximagePath: prefixIconPath,
          hintText: hintText,
          onChanged: onChanged ?? (data) {},
          textInputType: textInputType,
        ),
      ],
    );
  }
}
