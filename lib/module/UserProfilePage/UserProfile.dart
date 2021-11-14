import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/module/CartPage/Cart.dart';
import 'package:tech_shop/module/SearchPage/search.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/componants/constants.dart';
import 'package:tech_shop/shared/style/colors.dart';

import 'EditProfilePage/EditProfile.dart';


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

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
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: profileColor,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: profileColor,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(CartScreen());
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white, //Color(0xff727C8E),
                    ),
                  ),
                  CircleAvatar(
                    radius: 10.0,
                    backgroundColor: Colors.red.withOpacity(0.8),
                    child: Text(
                      ShopCubit.get(context)
                          .cartModel!
                          .data!
                          .cartItems
                          .length
                          .toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
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
                    color: Colors.white, //Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          body:  SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: profileColor,
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 45.0,
                        backgroundColor: Colors.white,
                        backgroundImage: cubit.profileModel == null
                            ? NetworkImage(
                                'https://ar.limu.edu.ly/wp-content/uploads/sites/18/2020/10/white-background-2-1-1-300x176.jpg')
                            : NetworkImage(
                                '${cubit.profileModel!.data!.image!}',
                                scale: 1.0,
                              ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.profileModel!.data!.name!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            cubit.profileModel!.data!.email!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(EditProfileScreen());
                        },
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
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
                          icon: Icons.home_outlined,
                          text: 'My Home',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {},
                          icon: Icons.location_on_outlined,
                          text: 'Adderess',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {},
                          icon: Icons.format_list_bulleted,
                          text: 'All My Orders',
                        ),
                        customLine(margin: 12.0),
                        buildThings(
                          onPressed: () {},
                          icon: Icons.lock_outlined,
                          text: 'Change Password',
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    logOut(context);
                  },
                  child: Text('LOG OUT'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
