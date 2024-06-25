import 'package:flutter/material.dart';

class TextFormGLobal extends StatelessWidget {
  const TextFormGLobal(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.text,
      required this.obsecure});
  final TextEditingController controller;
  final TextInputType textInputType;
  final String text;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(top: 3, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: TextField(
        obscureText: obsecure,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
          hintStyle: TextStyle(
            height: 1,
          ),
        ),
      ),
    );
  }
}
