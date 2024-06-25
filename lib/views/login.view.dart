import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juan_recipe/utils/backendConnection.dart';
import 'package:juan_recipe/utils/global.colors.dart';
import 'package:juan_recipe/views/home.view.dart';
import 'package:juan_recipe/views/register.view.dart';
import 'package:juan_recipe/views/widget/button.global.dart';
import 'package:juan_recipe/views/widget/social.login.dart';
import 'package:juan_recipe/views/widget/text.form.global.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();

    //REMOVING me PLEASE
    var token = prefs.getString('token');
    (token != null && JwtDecoder.isExpired(token) == false)
        // ? HomeView(token: token)
        ? HomeView(token: token)
        : LoginView();
    // ? HomeView(token: token)
    // : LoginView();
  }

  void loginFailed() {
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
    clearLoginFormText();
  }

  void clearLoginFormText() {
    emailController.clear();
    passwordController.clear();
  }

  loginSignIn() async {
    // VALIDATING INPUT FIELD WHETHER ITS EMPTY OR NOT
    if (!emailController.text.isNotEmpty) {
      // print("email has value");
      loginFailed();
      return false;
    }
    if (!passwordController.text.isNotEmpty) {
      // print("password has value");
      loginFailed();
      return false;
    }
    //REQUEST BODY
    var reqBody = {
      "email": emailController.text,
      "password": passwordController.text
    };
    //TRIGGERING POST REQUEST

    var response = await http.post(
      Uri.parse(
        Config.loginUrl,
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    //DECODING REPONSE
    var jsonResponse = jsonDecode(response.body);

    //CHECKING SUCCESS IS TRUE
    if (!jsonResponse['success'] == true) {
      print("di nag match");

      // ScaffoldMessenger.of(context)
      //   ..hideCurrentSnackBar()
      //   ..showSnackBar(failedSnackBar);

      //ALERTING FAILD LOGIN
      loginFailed();

      return false;
    }

    var myToken = jsonResponse['user']['token'];
    prefs.setString('token', myToken);
    print("this is login token ${myToken}");
    Get.to(HomeView(token: myToken));
    // Get.to(HomeView());
    // print(myToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 200,
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Login to your account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    // color: GlobalColors.textColor,
                  ),
                ),
                SizedBox(height: 15),
                TextFormGLobal(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  text: 'Email',
                  obsecure: false,
                ),
                SizedBox(height: 15),
                TextFormGLobal(
                  controller: passwordController,
                  textInputType: TextInputType.text,
                  text: 'Password',
                  obsecure: true,
                ),
                SizedBox(height: 15),
                // ButtonGlobal(
                //   emailController: emailController,
                //   passwordController: passwordController,
                // ),
                GestureDetector(
                  onTap: () {
                    loginSignIn();
                  },
                  child: ButtonGlobal(
                    text: 'Sign in',
                  ),
                ),
                // BURAHIN MO AKO
                SizedBox(height: 15),

                SizedBox(height: 15),
                SocialLogin(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        // color: Colors.black,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don\'t have an account? ",
              style: TextStyle(
                // color: GlobalColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                print("na click ang sign up");
                // Get.to(SplashView());
                Get.to(() => RegisterView());
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                    // color: GlobalColors.mainColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
