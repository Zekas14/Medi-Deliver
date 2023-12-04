import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/component/divider.dart';
import 'package:medi_deliver/screens/ExtensionFunctions.dart';
import 'package:medi_deliver/screens/HomePage.dart';
import 'package:medi_deliver/screens/Regestration.dart';
import 'package:medi_deliver/screens/Verification.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  String? email;
  String? password;

  Login({super.key});
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  static const String FontFamilyString = 'DINNextLTW23';
  bool checkboxState = false;
  static const Color FontprimaryColor = Color.fromRGBO(23, 43, 77, 1);
  static const Color FontSecondaryColor = Color.fromARGB(255, 122, 134, 154);
  static const Color secondaryColor = Color.fromARGB(255, 239, 240, 241);
  static const Color linksColor = Color.fromARGB(255, 250, 132, 70);
  GlobalKey<FormState> key = GlobalKey();
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      context.showCustomSnackBar(
          message: 'Log in Successufully', color: Colors.green);
    } on Exception {
      // ignore: use_build_context_synchronously
      context.showCustomSnackBar(
        message: 'Log in Failed',
        color: Colors.red,
      );
    }
  }

  Future signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on Exception catch (e) {
      print(e);
    }
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
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 0),
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
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Log In Now To Enjoy Our Service",
                  style: TextStyle(
                    color: FontSecondaryColor,
                    fontFamily: FontFamilyString,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              //Email
              const Row(
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                      color: FontSecondaryColor,
                      fontWeight: FontWeight.normal,
                      fontFamily: FontFamilyString,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyString,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFeild2(
                  onChanged: (data) {
                    widget.email = data;
                  },
                  prefiximagePath: 'asset/images/sms.png',
                  hintText: "Example@mail.com",
                  obscureText: false,
                ),
              ),
              //password
              const Row(
                children: [
                  Text(
                    "Password",
                    style: TextStyle(
                      color: FontSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: FontFamilyString,
                    ),
                  ),
                  Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyString,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: CustomTextFeild2(
                  onChanged: (data) {
                    widget.password = data;
                  },
                  prefiximagePath: 'asset/images/lock.png',
                  hintText: "Enter Password",
                  obscureText: true,
                  suffiximagePath: 'asset/images/eye.png',
                ),
              ),

              //renter password
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
                      "Remember Me ",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamilyString,
                        color: FontSecondaryColor,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Verification(),
                        ),
                      ),
                      // put the navigator in the on tap
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: linksColor,
                            fontFamily: FontFamilyString),
                      ),
                    ),
                  ],
                ),
              ),

              CustomButton(
                text: "Log In",
                onTap: () async {
                  if (key.currentState!.validate()) {
                    try {
                      UserCredential credential = await userSignIn();
                      // ignore: use_build_context_synchronously
                      context.showCustomDialog(const [
                        CircularProgressIndicator(
                          color: Color(0xFF34D49E),
                        ),
                        SizedBox(height: 16),
                        Text("Logging in..."),
                      ]);
                      // Simulate a delay (you can replace this with the actual login process)
                      await Future.delayed(const Duration(seconds: 1));
                      // Hide loading indicator
                      Navigator.pop(context);

                      // Check if login is successful
                      if (credential.user != null) {
                        // Show success message
                        // ignore: use_build_context_synchronously
                        context.showCustomSnackBar(
                            message: "Login successful", color: Colors.green);
                        await Future.delayed(Duration(seconds: 1));
                        // Navigate to the HomePage
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageScreen(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        // ignore: use_build_context_synchronously
                        context.showCustomSnackBar(
                          message: 'No user found for that email.',
                          color: Colors.red,
                        );
                      } else if (e.code == 'wrong-password') {
                        // ignore: use_build_context_synchronously
                        context.showCustomSnackBar(
                          message: 'Wrong password provided for that user.',
                          color: Colors.red,
                        );
                      }
                    }
                  }
                },
              ),

              const MyDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Image.asset('asset/images/google.png'),
                    onTap: () {
                      signInWithGoogle();
                    },
                  ),
                  const SizedBox(
                    width: 24,
                    height: 24,
                  ),
                  GestureDetector(
                    child: Image.asset('asset/images/facebook.png'),
                    onTap: () => signInWithFacebook(),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "  You Don't Have An Account ? ",
                        style: TextStyle(
                            fontFamily: FontFamilyString,
                            color: FontSecondaryColor),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        ),
                        child: const Text(
                          "Sign up",
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
                  )),
            ],
          ),
        )),
      ),
    );
  }

  Future<UserCredential> userSignIn() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: widget.email!,
      password: widget.password!,
    );
    return credential;
  }
}
