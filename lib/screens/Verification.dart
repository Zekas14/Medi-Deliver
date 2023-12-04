import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/screens/ExtensionFunctions.dart';

// ignore: must_be_immutable
class Verification extends StatelessWidget {
  String? email;
  Color errorColor = const Color.fromARGB(255, 202, 31, 18);
  GlobalKey<FormState> key = GlobalKey();
  Verification({super.key});
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text("Verification",
                style: TextStyle(
                  color: Colors.black, fontSize: 24,
                  //fontFamily: "Amiko"
                ),
                textAlign: TextAlign.right),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Please Enter Your Email ",
                    style: TextStyle(
                        fontSize: 14,
                        //fontFamily: "Amiko",
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7A869A)),
                  ),
                  const Text(
                    "To Receive A Verification Code",
                    style: TextStyle(
                        fontSize: 14,
                        //fontFamily: "Amiko",
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7A869A)),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 5),
                  const Text(
                    "E-mail",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff7A869A),
                      // fontFamily: "Amiko"
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Field is Required';
                      }
                    },
                    onChanged: (data) {
                      email = data;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 239, 240, 241),
                      hintText: 'Enter Your Gmail ',
                      hintStyle: const TextStyle(
                        color: Color(0xFFA5A5A5),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        //fontFamily: "Amiko"
                      ),
                      prefixIcon: Image.asset("asset/images/sms.png"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomButton(
                    text: "Send",
                    onTap: () async {
                      if (key.currentState!.validate()) {
                        // resetPassword(email!);
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email!);
                          // ignore: use_build_context_synchronously
                          context.showCustomSnackBar(
                            message: 'Password reset Send Successfully',
                            color: Colors.green,
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamed('Login');
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          context.showCustomSnackBar(
                            message: 'Not Available Email',
                            color: errorColor,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
