import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';

import 'package:medi_deliver/screens/loginPage.dart';
import 'package:medi_deliver/screens/screens_holder_nav.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  String? fullName;
  String? email;
  String? password;
  String? confiremPassword;

  SignUp({super.key});

  @override
  State<StatefulWidget> createState() => SingUpState();
}

class SingUpState extends State<SignUp> {
  bool checkboxState = false;
  GlobalKey<FormState> key = GlobalKey();
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
              IconButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                ),
                icon: const Icon(Icons.arrow_back),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Welcome to Medi-Deliver 👋",
                  style: TextStyle(
                    color: fontprimaryColor,
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
                children: [label("Password"), requiredSign],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
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
                children: [label('Re Enter Password'), requiredSign,],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
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
                    const InkWell(
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
                    const Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ),

              CustomButton(
                text: "Sign Up",
                onTap: () async {
                  if (key.currentState!.validate()) {
                    try {
                      if (widget.confiremPassword == widget.password) {
                        await userRegestration();
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
                            builder: (context) => ScreensHolderNav(),
                          ),
                        );
                      } else {
                        context.showCustomSnackBar(
                          message: 'Re Entered Password Not Matched ',
                          color: errorColor,
                        );
                      }
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

  Future<void> userRegestration() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: widget.email!,
      password: widget.password!,
    );
    // ignore: unused_local_variable
    UserCredential user = userCredential;
  }
}
