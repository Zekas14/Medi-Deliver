import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            height: 50,
            color: Color.fromARGB(255, 177, 175, 175),
            indent: 15,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(),
          child: Text(
            'Or Continue Using',
            style: TextStyle(
              color: Color.fromARGB(255, 177, 175, 175),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            height: 50,
            color: const Color.fromARGB(255, 177, 175, 175),
            endIndent: 8,
          ),
        ),
      ],
    );
  }
}
