import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/CartModel.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Text('Back'),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: fullBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: fullBackgroundColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: shopColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ShopCubit.get(context).cartModel == null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Center(
                      child: LinearProgressIndicator(
                    color: shopColor,
                  )),
                )
              : ShopCubit.get(context).cartModel!.data!.cartItems.isEmpty
                  ? customEmptyPage(
                      imagePath: 'assets/images/emptyCart.png',
                      width: 210.0,
                      height: 187.0,
                      text: 'Your Cart list is empty .',
                    )
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 16.0,
                              right: 16.0,
                              left: 16.0,
                              bottom: MediaQuery.of(context).size.height / 8,
                            ),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cart',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Color(0xff515C6F),
                                        ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => buildCarts(
                                      ShopCubit.get(context)
                                          .cartModel!
                                          .data!
                                          .cartItems[index],
                                      context,
                                      index,
                                    ),
                                    separatorBuilder: (context, index) =>
                                        customLine(),
                                    itemCount: ShopCubit.get(context)
                                        .cartModel!
                                        .data!
                                        .cartItems
                                        .length,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        buildTotalPrice(
                            ShopCubit.get(context).cartModel!.data!, context),
                      ],
                    ),
        );
      },
    );
  }
}

Widget buildCarts(
  CartItems model,
  context,
  index,
) =>
    Container(
      height: 146.0,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 65.0,
                    child: CachedNetworkImage(
                      imageUrl: model.product!.image!,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 95.0,
                      height: 95.0,
                      //fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.0, height: 1.3, color: Colors.grey[800]),
                ),
                //Spacer(),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ${model.product!.price}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: shopColor),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.product!.discount != 0)
                      Text(
                        model.product!.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    // Spacer(),
                    // CircleAvatar(
                    //   radius: 18.0,
                    //   backgroundColor:
                    //       ShopCubit.get(context).favourite[model.product!.id]!
                    //           ? shopColor
                    //           : Colors.grey,
                    //   child: IconButton(
                    //     onPressed: () {
                    //       ShopCubit.get(context)
                    //           .changeFavorites(model.product!.id!);
                    //       // print(model.id.toString());
                    //     },
                    //     icon: Icon(Icons.favorite_border),
                    //     iconSize: 18.0,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
                //Spacer(),
                Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RawMaterialButton(
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: shopColor,
                        onPressed: () {
                          ShopCubit.get(context).plusQuantity(
                              ShopCubit.get(context).cartModel!, index);
                          ShopCubit.get(context).updateCartData(
                            id: ShopCubit.get(context)
                                .cartModel!
                                .data!
                                .cartItems[index]
                                .id
                                .toString(),
                            quantity: ShopCubit.get(context).quantity,
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      Text(
                        (ShopCubit.get(context)
                            .cartModel!
                            .data!
                            .cartItems[index]
                            .quantity
                            .toString()),
                        style: TextStyle(fontSize: 23.0),
                      ),
                      RawMaterialButton(
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: shopColor,
                        onPressed: () {
                          ShopCubit.get(context).minusQuantity(
                              ShopCubit.get(context).cartModel!, index);
                          ShopCubit.get(context).updateCartData(
                            id: ShopCubit.get(context)
                                .cartModel!
                                .data!
                                .cartItems[index]
                                .id
                                .toString(),
                            quantity: ShopCubit.get(context).quantity,
                          );
                        },
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      Spacer(),
                      customCartIcon(
                        text: 'Delete',
                        onTap: () {
                          ShopCubit.get(context)
                              .changeCarts(productId: model.product!.id!);
                        },
                        color: Colors.red,
                        //ShopCubit.get(context).cart[model.product!.id]!
                        //     ? shopColor
                        //     : Colors.grey,
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildTotalPrice(Data model, context) => Container(
      //color: Colors.white,
      width: double.infinity,
      //height: 85.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(blurRadius: 3, color: Color(0xff7f8c8d), spreadRadius: 0.1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 14.0, left: 25, bottom: 15.0, right: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: Color(0xff515C6F).withOpacity(0.5),
                  ),
                ),
                Text(
                  '\$ ${model.total}',
                  style: TextStyle(
                    color: shopColor,
                    fontSize: 20.0,
                    height: 1.2,
                    fontWeight: FontWeight.w900,
                    //backgroundColor: Colors.yellow,
                  ),
                ),
                Text(
                  'Free domenstic shopping',
                  style: TextStyle(
                    color: Color(0xff515C6F),
                    fontSize: 12.0,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: shopColor),
                width: 165.0,
                height: 46,
                padding: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 8.0, left: 24.0),
                child: Row(
                  children: [
                    Text(
                      'Check Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14.0,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: shopColor,
                        size: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
