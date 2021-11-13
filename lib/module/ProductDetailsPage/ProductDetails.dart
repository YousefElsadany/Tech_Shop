import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/layout/ShopApp/ShopLayout.dart';
import 'package:tech_shop/model/ProductDetailsModel.dart';
import 'package:tech_shop/module/CartPage/Cart.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    PageController imagesController = PageController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ProductDetailsData? model =
            ShopCubit.get(context).productDetailsModel?.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('Details'),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: shopColor),
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
                      color: Color(0xff727C8E),
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
              state is ShopLoadingGetProductDetailsState
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: Color(0xff727C8E),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model!.id!);
                        print(model.id.toString());
                      },
                      icon: ShopCubit.get(context).favourite[model!.id]!
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red.withOpacity(0.8),
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Color(0xff727C8E),
                            ),
                    ),
            ],
          ),
          body: state is ShopLoadingGetProductDetailsState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 300,
                                    child: PageView.builder(
                                      controller: imagesController,
                                      itemBuilder: (context, index) =>
                                          CachedNetworkImage(
                                        imageUrl: model!.images![index],
                                      ),
                                      itemCount: model!.images!.length,
                                    ),
                                  ),
                                ),
                                SmoothPageIndicator(
                                  controller: imagesController,
                                  count: model.images!.length,
                                  effect: WormEffect(
                                    dotColor: Colors.grey,
                                    activeDotColor: shopColor,
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    spacing: 7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[350]!.withOpacity(0.8),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              ),
                            ),
                            padding: EdgeInsets.only(
                              top: 16.0,
                              right: 16.0,
                              left: 16.0,
                              bottom: MediaQuery.of(context).size.height / 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.name!,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$${model.price}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.blueGrey[900],
                                        //fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    if (model.discount != 0)
                                      Text(
                                        '\$ ${model.oldPrice}',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          //fontWeight: FontWeight.w900,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    if (model.discount != 0)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: shopColor,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Text(
                                          '${model.discount}% Off',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Container(
                                  color: Colors.grey[500],
                                  width: double.infinity,
                                  height: 1,
                                  padding: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 36.0, vertical: 8.0),
                                ),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    //color: Colors.grey[800],
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  model.description!,
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[350]!.withOpacity(0.8),
                      child: Row(
                        children: [
                          customCartBottom(
                            onTap: () {},
                            text: 'SHARE',
                            circulRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0)),
                            width: MediaQuery.of(context).size.width / 2,
                            height: 60.0,
                            color: Colors.white,
                            textColor: Colors.black,
                            circulAvatarColor: shopColor,
                            iconColor: Colors.white,
                            icon: Icons.share,
                          ),
                          Expanded(
                            child: customCartBottom(
                              onTap: () {
                                ShopCubit.get(context)
                                    .changeCarts(productId: model.id!);
                                scaffoldKey.currentState!.showBottomSheet(
                                  (context) => Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.name}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Added to Cart',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                //Navigator.pop(context);
                                                Get.offAll(ShopLayout());
                                              },
                                              child: Text(
                                                'CONTINUE SHOPPING',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.to(CartScreen());
                                                ShopCubit.get(context)
                                                    .currentIndex = 3;
                                              },
                                              child: Text('CHECKOUT'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  elevation: 50,
                                );
                              },
                              text: 'ADD CART',
                              circulRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0)),
                              width: MediaQuery.of(context).size.width / 2,
                              height: 60.0,
                              color: shopColor,
                              textColor: Colors.white,
                              circulAvatarColor: Colors.white,
                              iconColor: shopColor,
                              icon: Icons.arrow_forward_ios,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
