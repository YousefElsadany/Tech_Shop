import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/CategoriesDetailsModel.dart';
import 'package:tech_shop/module/ProductDetailsPage/ProductDetails.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';


class CategoryDetailsScreen extends StatelessWidget {
  final String? categoryName;
  CategoryDetailsScreen(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Text(categoryName!),
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
          body: state is ShopLoadingGetCategroyDetailsState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ShopCubit.get(context).categoryDetailModel!.data!.total == 0
                  ? customEmptyPage(
                      imagePath: 'assets/images/empty.png',
                      width: 210.0,
                      height: 187.0,
                      text: '${categoryName!} list is empty .',
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Color(0xffecf0f1),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              childAspectRatio: 1 / 1.67,
                              children: List.generate(
                                ShopCubit.get(context)
                                    .categoryDetailModel!
                                    .data!
                                    .productData
                                    .length,
                                (index) => customCategoryDetails(
                                  ShopCubit.get(context)
                                      .categoryDetailModel!
                                      .data!
                                      .productData[index],
                                  context,
                                ),
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

Widget customCategoryDetails(ProductData model, context) => InkWell(
      onTap: () {
        ShopCubit.get(context).getProductDetails(model.id!);
        Get.to(ProductsDetails());
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    InkWell(
                      onTap: () {
                        ShopCubit.get(context).getProductDetails(model.id!);

                        Get.to(ProductsDetails());
                      },
                      child: CachedNetworkImage(
                        imageUrl: model.image!,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: double.infinity,
                        height: 200.0,
                      ),
                    ),
                    CircleAvatar(
                      radius: 18.0,
                      backgroundColor:
                          ShopCubit.get(context).favourite[model.id]!
                              ? shopColor
                              : Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);

                          print(model.id.toString());
                        },
                        icon: Icon(Icons.favorite_border),
                        iconSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8.0, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$ ${model.price.round()}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: shopColor),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    customCartIcon(
                      text: 'Add Cart',
                      onTap: () {
                        ShopCubit.get(context)
                            .changeCarts(productId: model.id!);
                      },
                      color: ShopCubit.get(context).cart[model.id]!
                          ? shopColor
                          : Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
