import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/module/AboutUsPage/AboutUs.dart';
import 'package:tech_shop/module/AdderessPage/Adderess.dart';
import 'package:tech_shop/module/ComplaintsPage/Complaints.dart';
import 'package:tech_shop/module/ContactUsPage/ContactUs.dart';
import 'package:tech_shop/module/FAQsPage/FAQs.dart';
import 'package:tech_shop/module/TermsPage/Terms.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if (state is ShopSuccessUpdateProfileState) {
        //   showTast(text: 'Update Success', state: ToastStates.SUCCESS);
        // }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        buildThings(
                          onPressed: () {},
                          icon: Icons.payment_outlined,
                          text: 'Payment Method',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {
                            Get.to(Adderesscreen());
                          },
                          icon: Icons.location_on_outlined,
                          text: 'Adderess',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {},
                          icon: Icons.emoji_flags_outlined,
                          text: 'Country',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {
                            Get.to(ContactUsScreen());
                          },
                          icon: Icons.contact_phone,
                          text: 'Contact Us',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        buildThings(
                          onPressed: () {
                            Get.to(Complaintscreen());
                          },
                          icon: Icons.support,
                          text: 'Complaints',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {
                            Get.to(FAQsScreen());
                          },
                          icon: Icons.question_answer_outlined,
                          text: 'FAQs',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {
                            Get.to(AboutUsScreen());
                          },
                          icon: Icons.people_alt_outlined,
                          text: 'About Us',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {
                            Get.to(TermsScreen());
                          },
                          icon: Icons.note_alt_outlined,
                          text: 'Terms and Conditions',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
