import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_shop/shared/style/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          // child: Column(
          //   children: [
          //     buildMore(
          //       onTap: () {
          //         Get.to(ContactUsScreen());
          //       },
          //       imagePath: 'assets/images/contactus.png',
          //       text: 'Contact Us',
          //     ),
          //     SizedBox(
          //       height: 12.0,
          //     ),
          //     buildMore(
          //       onTap: () {
          //         Get.to(AboutUsScreen());
          //       },
          //       imagePath: 'assets/images/aboutus.png',
          //       text: 'About Us',
          //     ),
          //     SizedBox(
          //       height: 12.0,
          //     ),
          //     buildMore(
          //       onTap: () {
          //         Get.to(TermsScreen());
          //       },
          //       imagePath: 'assets/images/terms.png',
          //       text: 'Terms and Conditions',
          //     ),
          //   ],
          // ),
          ),
    );
  }
}

Widget buildMore(
        {required onTap, required String imagePath, required String text}) =>
    InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 108.0,
            height: 108.0,
            decoration: BoxDecoration(
              color: shopColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50.0),
            ),
            padding: EdgeInsets.all(12.0),
            child: Image(
              image: AssetImage(
                imagePath,
              ),
              width: 96.0,
              height: 96.0,
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
