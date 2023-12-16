import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/component/divider.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/screens/Regestration.dart';
import 'package:medi_deliver/screens/Verification.dart';
import 'package:medi_deliver/screens/screens_holder_nav.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  String? email;
  String? password;

  Login({super.key});
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool checkboxState = false;
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
        message: 'Log in With Google Failed',
        color: errorColor,
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
    } on Exception {

      // ignore: use_build_context_synchronously
      context.showCustomSnackBar(
          message: "Log in With Facebook Failed", color: errorColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
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
                      color: fontprimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontFamilyString),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Log In Now To Enjoy Our Service",
                  style: TextStyle(
                    color: fontSecondaryColor,
                    fontFamily: fontFamilyString,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              //Email
              Row(
                children: [
                  label("Email"),
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
              Row(
                children: [
                  label('Password'),
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
                        activeColor: fontSecondaryColor,
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
                        fontFamily: fontFamilyString,
                        color: fontSecondaryColor,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
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
                          fontFamily: fontFamilyString,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              CustomButton(
                text: "Log In",
                onTap: () async {
                  if (formkey.currentState!.validate()) {
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
                            builder: (context) =>  ScreensHolderNav(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        // ignore: use_build_context_synchronously
                        context.showCustomSnackBar(
                          message: 'No user found for that email.',
                          color: errorColor,
                        );
                      } else if (e.code == 'wrong-password') {
                        // ignore: use_build_context_synchronously
                        context.showCustomSnackBar(
                          message: 'Wrong password provided for that user.',
                          color: errorColor,
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
                            fontFamily: fontFamilyString,
                            color: fontSecondaryColor),
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
                            fontFamily: fontFamilyString,
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
