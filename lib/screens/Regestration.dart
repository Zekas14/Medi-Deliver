import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/screens/ExtensionFunctions.dart';
import 'package:medi_deliver/screens/HomePage.dart';
import 'package:medi_deliver/screens/loginPage.dart';

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
  static const String FontFamilyString = 'DINNextLTW23';

  bool checkboxState = false;
  static const Color FontprimaryColor = Color.fromRGBO(23, 43, 77, 1);
  static const Color FontSecondaryColor = Color.fromARGB(255, 122, 134, 154);
  static const Color secondaryColor = Color.fromARGB(255, 239, 240, 241);
  static const Color linksColor = Color.fromARGB(255, 250, 132, 70);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    color: FontprimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyString),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Sign Up Now To Enjoy Our Service",
                style: TextStyle(
                    color: FontSecondaryColor, fontFamily: FontFamilyString),
              ),
            ),

            const Row(
              children: [
                Text(
                  "Full Name",
                  style: TextStyle(
                      color: FontSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyString),
                ),
                Text(
                  " *",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyString),
                )
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

            const Row(
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                      color: FontSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyString),
                ),
                Text(
                  " *",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyString),
                )
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
            const Row(
              children: [
                Text(
                  "Password",
                  style: TextStyle(
                    color: FontSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyString,
                  ),
                ),
                Text(
                  " *",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyString,
                  ),
                )
              ],
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
            const Row(
              children: [
                Text(
                  "Re Enter Password",
                  style: TextStyle(
                    color: FontSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyString,
                  ),
                ),
                Text(
                  " *",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
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
                      activeColor: FontSecondaryColor,
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
                      fontFamily: FontFamilyString,
                      color: FontSecondaryColor,
                    ),
                  ),
                  const InkWell(
                    // put the navigator in the on tap
                    child: Text(
                      "Terms and Conditions",
                      style: TextStyle(
                          fontSize: 13,
                          color: linksColor,
                          fontFamily: FontFamilyString),
                    ),
                  ),
                  const Text(
                    " of the App",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: FontFamilyString,
                      color: FontSecondaryColor,
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
                try {
                  if (widget.email == null ||
                      widget.password == null ||
                      widget.fullName == null) {
                    context.showCustomSnackBar(
                      message: "Name or Email or Password can't be Empty",
                      color: Colors.red,
                    );
                  } else {
                    if (widget.confiremPassword == widget.password) {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential userCredential =
                          await auth.createUserWithEmailAndPassword(
                        email: widget.email!,
                        password: widget.password!,
                      );
                      // ignore: unused_local_variable
                      UserCredential user = userCredential;
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // prevents dismissing by tapping outside
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: Color(0xFF34D49E),
                                ),
                                SizedBox(height: 16),
                                Text("Logging in..."),
                              ],
                            ),
                          );
                        },
                      );

                      // Simulate a delay (you can replace this with the actual login process)
                      await Future.delayed(const Duration(seconds: 1));

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageScreen(),
                        ),
                      );
                    } else {
                      context.showCustomSnackBar(
                        message: 'Re Entered Password Not Matched ',
                        color: Colors.red,
                      );
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    // ignore: use_build_context_synchronously
                    context.showCustomSnackBar(
                        message: 'Weak Password', color: Colors.red);
                  } else if (e.code == 'email-already-in-use') {
                    context.showCustomSnackBar(
                      message: 'The Email already used ',
                      color: Colors.red,
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString()),
                  ));
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
                          fontFamily: FontFamilyString,
                          color: FontSecondaryColor),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: linksColor,
                          fontFamily: FontFamilyString,
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
    );
  }
}
