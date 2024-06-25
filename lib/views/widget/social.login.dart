import 'package:flutter/material.dart';
// import 'package:login_signup/utils/global.colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 55,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "- Or Sign in With -",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              // color: GlobalColors.textColor,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              children: [
                //GOOGLE ICON
                Expanded(
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      "assets/images/google.svg",
                      height: 40,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                //FACEBOOK ICON
                Expanded(
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      "assets/images/facebook.svg",
                      height: 40,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                //TWITTER ICON
                Expanded(
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      "assets/images/twitter.svg",
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
