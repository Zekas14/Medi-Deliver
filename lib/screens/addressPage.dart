import 'package:flutter/material.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/core/constants.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title:const Text(
            '              Address',
            style: TextStyle(
              fontSize: 24,
              fontFamily: fontFamilyString,
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 10,),
              GestureDetector(
                onTap: (){

                },
                child:  Image.asset(
                  'asset/images/profile.png',
                  width: 90,
                ),),
                const SizedBox(height: 10,),
                fieldContianer('Area'),
                fieldContianer('Street Name'),
                fieldContianer('Building Name'),
                fieldContianer('Floor Number'),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(text: 'Save'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldContianer(String text) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: label(text, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        CustomTextFeild2(obscureText: false),
      ],
    );
  }
}
