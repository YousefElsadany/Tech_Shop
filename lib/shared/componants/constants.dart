import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tech_shop/module/ShopLoginPage/ShopLogin.dart';
import 'package:tech_shop/shared/network/local/CachHelper.dart';
import 'package:tech_shop/shared/style/colors.dart';

//ShopLoginModel? model;
void signOut() {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      Get.offAll(LoginShopScreen());
      print('SIGN OUT SUCCESS');
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';

void logOut(context) {
  showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('SignOut'),
      elevation: 240.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      // contentPadding: EdgeInsets.only(
      //   top: 10.0,
      //   left: 24.0,
      // ),
      content: Text('Do you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: shopColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () => signOut(),
          child: const Text(
            'OK',
            style: TextStyle(
              color: shopColor,
            ),
          ),
        ),
      ],
    ),
  );
}




// Widget customCategoriesItems(DataModel model) => Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           CachedNetworkImage(
//             imageUrl: model.image!,
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             height: 100.0,
//             width: 100.0,
//             fit: BoxFit.cover,
//           ),
//           Container(
//               color: Colors.black.withOpacity(0.8),
//               width: 100.0,
//               child: Text(
//                 model.name!,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ))
//         ],
//       );