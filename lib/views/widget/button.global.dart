// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:juan_recipe/utils/global.colors.dart';

// import 'package:login_signup/utils/global.colors.dart';

// import 'package:http/http.dart' as http;

class ButtonGlobal extends StatelessWidget {
  final String text;

  const ButtonGlobal({
    Key? key,
    required this.text,
  }) : super(key: key);

  // final TextEditingController emailController;
  // final TextEditingController passwordController;

  // Future<void> clickLogin() async {
  //   if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
  //     var reqBody = {
  //       "email": emailController.text,
  //       "password": passwordController.text
  //     };

  //     var response = await http.post(Uri.parse(Config.url),
  //         headers: {"Content-Type": "application/json"},
  //         body: jsonEncode(reqBody));

  //     var jsonResponse = jsonDecode(response.body);

  //     print(jsonResponse);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: GlobalColors.mainColor,
        color: GLobalColors.orangeColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      ),
    );
  }
}
