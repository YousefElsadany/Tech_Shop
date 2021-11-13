import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tech_shop/module/ShopLoginPage/ShopLogin.dart';
import 'package:tech_shop/shared/network/local/CachHelper.dart';
import 'package:tech_shop/shared/style/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  // final boardController = PageController();

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBordingScreen extends StatefulWidget {
  @override
  _OnBordingScreenState createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  bool isLast = false;

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fullBackgroundColor,
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                CacheHelper.putBool(key: 'onBoarding', value: true);
                Get.offAll(LoginShopScreen());
              },
              child: Text(
                'SKIP',
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildBoardingItems(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      boardController.previousPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: SwapEffect(
                      activeDotColor: shopColor,
                      spacing: 5.0,
                      //expansionFactor: 4.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        CacheHelper.putBool(key: 'onBoarding', value: true);
                        Get.offAll(LoginShopScreen());
                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      isLast ? Icons.login : Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/onboard_1.jpg',
    title: 'Shop Anything',
    body: 'Find you desired products form \n thousands of products !',
  ),
  BoardingModel(
    image: 'assets/images/onboard_2.png',
    title: 'Order Easily',
    body: 'Easily order any products \n you want to buy !',
  ),
  BoardingModel(
    image: 'assets/images/onboard_3.png',
    title: 'Fast Deliver',
    body:
        'Order will be delivered on your doorstep \n in quickest time possible !',
  ),
];
var boardController = PageController();
Widget buildBoardingItems(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        // SmoothPageIndicator(
        //   controller: boardController,
        //   count: boarding.length,
        //   effect: SwapEffect(
        //       activeDotColor: shopColor,
        //       spacing: 5.0,
        //       // expansionFactor: 4.0,
        //       dotWidth: 10.0,
        //       dotHeight: 10.0),
        // ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
