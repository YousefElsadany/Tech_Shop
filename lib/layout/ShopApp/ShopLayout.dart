import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/module/CartPage/Cart.dart';
import 'package:tech_shop/module/NotificationPage/Notifications.dart';
import 'package:tech_shop/module/SearchPage/search.dart';
import 'package:tech_shop/module/UserProfilePage/UserProfile.dart';
import 'package:tech_shop/shared/style/colors.dart';

import 'Cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var lauoutCubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/logoapp.jpg',
                  width: 50.0,
                  height: 55.0,
                ),
                Text(
                  'Tech Shop',
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.to(UserProfileScreen());
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person_outline,color: Colors.grey[800],),
                  // AssetImage('assets/images/profile.png'),
                  // lauoutCubit.profileModel == null
                  //     ? NetworkImage(
                  //         'https://ar.limu.edu.ly/wp-content/uploads/sites/18/2020/10/white-background-2-1-1-300x176.jpg')
                  //     : NetworkImage(
                  //         lauoutCubit.profileModel!.data!.image!,
                  //       ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).getNotifications();
                      Get.to(NotificationsScreen());
                    },
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.grey[800],
                    ),
                  ),
                  CircleAvatar(
                    radius: 10.0,
                    backgroundColor: Colors.red.withOpacity(0.8),
                    child: Text(
                      ShopCubit.get(context).notificationsModel != null
                          ? ShopCubit.get(context)
                              .notificationsModel!
                              .data!
                              .total
                              .toString()
                          : '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    Get.to(SeachScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(CartScreen());
            },
            child: Icon(Icons.shopping_cart),
            backgroundColor: shopColor,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: lauoutCubit.bottomsIcons,
            activeIndex: lauoutCubit.currentIndex,
            onTap: (index) {
              lauoutCubit.changeNavBar(index);
            },
            activeColor: shopColor,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
          ),
          body: lauoutCubit.screen[lauoutCubit.currentIndex],

        );

      },
    );
  }
}
