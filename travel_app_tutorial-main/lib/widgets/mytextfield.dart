import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool obscuerText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hinttext,
    required this.obscuerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscuerText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Color.fromARGB(255, 225, 225, 225)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: hinttext,
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
                fontSize: 14)),
      ),
    );
  }
}
