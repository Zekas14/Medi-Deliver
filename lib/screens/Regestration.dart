import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:medi_deliver/model/user.dart' as model;

import 'package:medi_deliver/screens/loginPage.dart';
import 'package:medi_deliver/screens/screens_holder_nav.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  String? fullName;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? confiremPassword;

  SignUp({super.key});

  @override
  State<StatefulWidget> createState() => SingUpState();
}

class SingUpState extends State<SignUp> {
  bool checkboxState = false;
  GlobalKey<FormState> key = GlobalKey();
  String? termsText;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    termsText = '';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: key,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'asset/images/logo.png',
                width: 80,
              ),

              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Welcome to Medi-Deliver 👋",
                  style: TextStyle(
                    color: Color.fromARGB(255, 23, 43, 77),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilyString,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Sign Up Now To Enjoy Our Service",
                  style: TextStyle(
                    color: fontSecondaryColor,
                    fontFamily: fontFamilyString,
                  ),
                ),
              ),

              Row(
                children: [
                  label("Full Name"),
                  requiredSign,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
                  borderColor: Colors.white,
                  // ignore: body_might_complete_normally_nullable
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'Field is Required';
                    } else if (data.length <= 2) {
                      return 'Name isn\'t Valid ';
                    } else if (RegExp(r'\d').hasMatch(data)) {
                      return 'Name should not contain numbers';
                    }
                  },
                  onChanged: (data) {
                    widget.fullName = data;
                  },
                  prefiximagePath: 'asset/images/user.png',
                  hintText: "Enter Your Full Name",
                  obscureText: false,
                ),
              ),
              //Email
              Row(
                children: [
                  label("Email"),
                  requiredSign,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
                  // ignore: body_might_complete_normally_nullable
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'Field is Required';
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(data)) {
                      return 'Invalid Email Format';
                    }
                  },
                  borderColor: Colors.white,
                  onChanged: (data) {
                    widget.email = data;
                  },
                  prefiximagePath: 'asset/images/sms.png',
                  hintText: "Example@mail.com",
                  obscureText: false,
                ),
              ),
              // Password
              Row(
                children: [
                  label("Mobile Number"),
                  requiredSign,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
                  // ignore: body_might_complete_normally_nullable
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'Field is Required';
                    } else if (data.length < 10) {
                      return 'Mobile number is too short';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(data)) {
                      return 'Invalid characters in the mobile number';
                    }
                  },
                  maxLenght: 11,
                  textInputType: TextInputType.phone,
                  borderColor: Colors.white,
                  onChanged: (data) {
                    widget.phone = data;
                  },
                  prefiximagePath: 'asset/images/call.png',
                  hintText: "01060582526",
                  obscureText: false,
                ),
              ),
              Row(
                children: [
                  label("City/Address"),
                  requiredSign,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
                  // ignore: body_might_complete_normally_nullable
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'Field is Required';
                    } else if (data.length < 5) {
                      return 'Address is too short';
                    }
                  },
                  onChanged: (data) {
                    widget.address = data;
                  },
                  prefiximagePath: 'asset/images/addressicon.png',
                  hintText: "Assuit, City",
                  obscureText: false,
                ),
              ),
              // Password
              Row(
                children: [label("Password"), requiredSign],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
                  // ignore: body_might_complete_normally_nullable
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'Field is Required';
                    } else if (data.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+,-./:;<=>?@[\]^_`{|}~])')
                        .hasMatch(data)) {
                      return 'Password must include uppercase, lowercase, number, and special character';
                    }
                  },
                  borderColor: Colors.white,
                  onChanged: (data) {
                    widget.password = data;
                  },
                  prefiximagePath: 'asset/images/lock.png',
                  hintText: "Enter Password",
                  obscureText: true,
                  suffiximagePath: 'asset/images/eye.png',
                ),
              ),

              // Re-enter password
              Row(
                children: [
                  label('Re Enter Password'),
                  requiredSign,
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
                  // ignore: body_might_complete_normally_nullable
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'Field is Required';
                    } else if (data != widget.password) {
                      return 'Password Not Matched';
                    }
                  },
                  borderColor: Colors.white,
                  prefiximagePath: 'asset/images/lock.png',
                  hintText: "Re Enter Password",
                  obscureText: true,
                  suffiximagePath: 'asset/images/eye.png',
                  onChanged: (data) {
                    // Check if the entered password matches the original password
                    widget.confiremPassword = data;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  children: [
                    Checkbox(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        activeColor: fontSecondaryColor,
                        value: checkboxState,
                        onChanged: (value) {
                          setState(() {
                            checkboxState = !checkboxState;
                            // Set termsText to an empty string when the checkbox state changes
                            termsText = '';
                          });
                        }),
                    const Text(
                      "I Agree to the ",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontFamilyString,
                        color: fontSecondaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: _showTermsDialog,
                      // put the navigator in the on tap
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(
                            fontSize: 13,
                            color: linksColor,
                            fontFamily: fontFamilyString),
                      ),
                    ),
                    const Text(
                      " of the App",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontFamilyString,
                        color: fontSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                termsText!,
                style: TextStyle(color: errorColor, fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "Sign Up",
                color: checkboxState && key.currentState!.validate()
                    ? buttonColor
                    : Color.fromARGB(255, 176, 176, 176),
                onTap: () async {
                  if (key.currentState!.validate()) {
                    if (checkboxState) {
                      try {
                        await userRegistration();
                        // ignore: use_build_context_synchronously
                        context.showCustomDialog(const [
                          CircularProgressIndicator(
                            color: Color(0xFF34D49E),
                          ),
                          SizedBox(height: 16),
                          Text("Signing up.."),
                        ]);
                        // Simulate a delay (you can replace this with the actual login process)
                        await Future.delayed(const Duration(seconds: 1));
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScreensHolderNav(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          // ignore: use_build_context_synchronously
                          context.showCustomSnackBar(
                            message: 'Weak Password',
                            color: errorColor,
                          );
                        } else if (e.code == 'email-already-in-use') {
                          // ignore: use_build_context_synchronously
                          context.showCustomSnackBar(
                            message: 'The Email already used ',
                            color: errorColor,
                          );
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                        ));
                      }
                    } else {
                      setState(() {
                        termsText = 'You Must Accept Terms And Conditions';
                      });
                    }
                  }
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      const Text(
                        "Already Have Account ? ",
                        style: TextStyle(
                          fontFamily: fontFamilyString,
                          color: fontSecondaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: linksColor,
                            fontFamily: fontFamilyString,
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }

  Future<void> userRegistration() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email!,
        password: widget.password!,
      );

      // Access the UserProvider and set the loggedInUser
      Provider.of<UserProvider>(context, listen: false)
          .setLoggedInUser(model.User(
        uid: userCredential.user?.uid,
        fullName: widget.fullName,
        email: widget.email,
        phoneNumber: widget.phone,
        address: widget.address,
        profileImage: 'asset/images/profile.png',
      ));

      // Add user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'fullName': widget.fullName,
        'email': widget.email,
        'Address': widget.address,
        'phone': widget.phone,
        'image':
            'https://firebasestorage.googleapis.com/v0/b/medi-deliver.appspot.com/profile_images/1000132332.jpg?alt=media&token=717ff51f-1d5a-43e5-acb4-3e613dd77a12',
      });

    } on FirebaseAuthException {
    } catch (e) {
    }
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Terms and Conditions",
            style: TextStyle(
              color: fontSecondaryColor,
              fontFamily: fontFamilyString,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              '''
  **Terms and Conditions for Medi-Deliver App**

  **Effective Date: [Date]**

  These terms and conditions ("Terms") are a legal agreement between you ("User" or "you") and Medi-Deliver ("we," "us," or "our") governing your use of the Medi-Deliver mobile application ("App") and related services.

  **1. Acceptance of Terms**

  By using the App, you agree to comply with and be bound by these Terms. If you do not agree with these Terms, please do not use the App.

  **2. Registration and User Accounts**

  a. You must provide accurate and complete information during the registration process.

  b. You are responsible for maintaining the confidentiality of your account credentials.

  c. You must promptly notify us of any unauthorized use or suspected security breach of your account.

  **3. Medical Information and Prescriptions**

  a. The App provides information related to medicines, healthcare, and general wellness. This information is for informational purposes only and should not be considered medical advice.

  b. Prescription medicines will only be dispensed upon submission of a valid prescription from a licensed healthcare professional.

  **4. Delivery Services**

  a. The App offers medicine delivery services. Delivery times may vary based on location and demand.

  b. You must provide accurate delivery information. We are not responsible for deliveries to incorrect addresses provided by you.

  **5. User Conduct**

  a. You agree not to misuse the App, engage in any unlawful activities, or violate these Terms.

  b. You are solely responsible for your interactions with healthcare professionals and other users.

  **6. Privacy Policy**

  Your use of the App is also governed by our Privacy Policy, which can be found at [Link to Privacy Policy]. Please review the Privacy Policy to understand our practices.

  **7. Termination**

  We reserve the right to terminate or suspend your account and access to the App for any reason, including violation of these Terms.

  **8. Disclaimer of Warranties**

  The App is provided "as is" without warranties of any kind, either express or implied. We do not guarantee the accuracy, completeness, or timeliness of information provided.

  **9. Limitation of Liability**

  To the fullest extent permitted by applicable law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages.

  **10. Governing Law**

  These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction].

  **11. Changes to Terms**

  We reserve the right to modify these Terms at any time. You are responsible for regularly reviewing these Terms.

  **Contact Information**

  If you have any questions or concerns about these Terms, please contact us at [Your Contact Information].
  ''',
              style: TextStyle(
                fontSize: 16,
                fontFamily: fontFamilyString,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(
                  color: buttonColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
