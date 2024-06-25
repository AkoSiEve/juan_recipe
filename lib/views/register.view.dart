import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juan_recipe/utils/backendConnection.dart';
import 'package:juan_recipe/utils/global.colors.dart';
import 'package:juan_recipe/views/widget/button.global.dart';
import 'package:juan_recipe/views/widget/text.form.global.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController firstNameControllerSignup =
      TextEditingController();
  final TextEditingController lastNameControllerSignup =
      TextEditingController();
  final TextEditingController emailControllerSignup = TextEditingController();

  final TextEditingController passwordControllerSignup =
      TextEditingController();
  final TextEditingController cpasswordControllerSignup =
      TextEditingController();

  registerFailed() {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text('Invalid credential, Please try again'),
      // style: ToastificationStyle.flatColored,
      style: ToastificationStyle.minimal,
      type: ToastificationType.error,
      showProgressBar: false,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
    );
    // clearLoginFormText();
  }

  registerSuccess() {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text('your account has been registerd'),
      // style: ToastificationStyle.flatColored,
      style: ToastificationStyle.minimal,
      type: ToastificationType.success,
      showProgressBar: false,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  registerSignIn() async {
    if (!firstNameControllerSignup.text.isNotEmpty) {
      // print("email has value");
      registerFailed();
      return false;
    }
    if (!lastNameControllerSignup.text.isNotEmpty) {
      // print("email has value");
      registerFailed();
      return false;
    }
    if (!emailControllerSignup.text.isNotEmpty) {
      // print("email has value");
      registerFailed();
      return false;
    }
    if (!passwordControllerSignup.text.isNotEmpty) {
      print("password has no value");
      registerFailed();
      return false;
    }
    if (!(passwordControllerSignup.text == cpasswordControllerSignup.text)) {
      print("cpassword has not match");
      registerFailed();
      return false;
    }

    var reqBody = {
      "firstname": firstNameControllerSignup.text,
      "lastname": lastNameControllerSignup.text,
      "email": emailControllerSignup.text,
      "password": passwordControllerSignup.text
    };
    //TRIGGERING POST REQUEST
    var response = await http.post(
      Uri.parse(
        Config.registerUrl,
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    //DECODING REPONSE
    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse['success']);
    if (!jsonResponse['success'] == true) {
      print("di nag match");
      registerFailed();

      return false;
    }
    print("sucess sya");
    registerSuccess();
    clearLoginFormText();
    Timer(const Duration(milliseconds: 3000), () => Get.back());
  }

  void clearLoginFormText() {
    firstNameControllerSignup.clear();
    lastNameControllerSignup.clear();
    emailControllerSignup.clear();
    passwordControllerSignup.clear();
    cpasswordControllerSignup.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Get.to(LoginView());
              Get.back();
            },
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // color: Colors.green,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.red,
                  alignment: Alignment.center,
                  // child: Text(
                  //   "Logo",
                  //   style: TextStyle(
                  //     fontSize: 50,
                  //     fontWeight: FontWeight.bold,
                  //     color: GLobalColors.orangeColor,
                  //   ),
                  // ),
                  child: Image.network(
                    'https://i.pinimg.com/564x/ea/05/48/ea05484227d5789931972408ca585771.jpg',
                    // color: Colors.red,
                    height: 130,
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    // color: GlobalColors.textColor,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormGLobal(
                        // controller: emailController,
                        controller: firstNameControllerSignup,
                        textInputType: TextInputType.emailAddress,
                        text: 'First name',
                        obsecure: false,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextFormGLobal(
                        // controller: emailController,
                        controller: lastNameControllerSignup,
                        textInputType: TextInputType.emailAddress,
                        text: 'Last name',
                        obsecure: false,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                TextFormGLobal(
                  // controller: emailController,
                  controller: emailControllerSignup,
                  textInputType: TextInputType.emailAddress,
                  text: 'Email',
                  obsecure: false,
                ),
                SizedBox(height: 15),
                TextFormGLobal(
                  controller: passwordControllerSignup,
                  textInputType: TextInputType.text,
                  text: 'Password',
                  obsecure: true,
                ),
                SizedBox(height: 15),
                TextFormGLobal(
                  controller: cpasswordControllerSignup,
                  textInputType: TextInputType.text,
                  text: 'Confirm Password',
                  obsecure: true,
                ),
                SizedBox(height: 15),
                // ButtonGlobal(
                //   emailController: emailController,
                //   passwordController: passwordController,
                // ),
                InkWell(
                  onTap: () {
                    registerSignIn();
                  },
                  child: ButtonGlobal(
                    text: 'Sign up',
                  ),
                ),
                // BURAHIN MO AKO
                SizedBox(height: 15),

                SizedBox(height: 15),
                // SocialLogin(),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 55,
      //   // color: Colors.black,
      //   alignment: Alignment.center,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Don\'t have an account? ",
      //         style: TextStyle(
      //           color: GlobalColors.textColor,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //       InkWell(
      //         onTap: () {
      //           print("na click ang sign up");
      //           // Get.to(SplashView());
      //           Get.to(() => RegisterView());
      //         },
      //         child: Text(
      //           "Sign Up",
      //           style: TextStyle(
      //             color: GlobalColors.mainColor,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
