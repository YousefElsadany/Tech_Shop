import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/CategoriesModel.dart';
import 'package:tech_shop/model/ShopModel.dart';
import 'package:tech_shop/module/AdderessPage/MapPage.dart';
import 'package:tech_shop/module/CategoryDetails/CategoryDetails.dart';
import 'package:tech_shop/module/ProductDetailsPage/ProductDetails.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';


// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model!.status!) {
            showTast(text: state.model!.message, state: ToastStates.ERROR);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.model!.message!),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
        if (state is ShopSuccessChangeCartsState) {
          if (!state.model!.status!) {
            showTast(text: state.model!.message, state: ToastStates.ERROR);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.model!.message!),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productCustom(ShopCubit.get(context).homeModel!,
                  ShopCubit.get(context).categoriesModel!, context),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: ()  {
                  Get.to(MapsPage());
                },
                label: Row(
                  children: [
                    Icon(Icons.map,color:shopColor,),
                    SizedBox(width: 5.0,),
                    Text('Map',style: TextStyle(color: shopColor),),
                  ],
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Colors.white,
                //icon: const Icon(Icons.map, size: 30.0),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget productCustom(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Categories',
            //   style: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.w800,
            //     color: Color(0xff515C6F),
            //   ),
            // ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Container(
                //padding: EdgeInsets.symmetric(horizontal: 12.0),
                height: 130.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => customCategoriesItems(
                      categoriesModel.data!.data[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10.0,
                  ),
                  itemCount: categoriesModel.data!.data.length,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            // Text(
            //   'Best Sales',
            //   style: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.w800,
            //     color: Color(0xff515C6F),
            //   ),
            // ),
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => ClipRRect(
                      // borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: e.image,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 220.0,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            // Image(
            //     image: NetworkImage(
            //   model.data.ad!,
            // )),
            SizedBox(
              height: 5.0,
            ),
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
                    model.data.products.length,
                    (index) =>
                        customProduct(model.data.products[index], context)),
              ),
            ),
          ],
        ),
      );
  Widget customProduct(ProductsModel model, context) => Container(
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
                        ShopCubit.get(context).getProductDetails(model.id);
                        Get.to(ProductsDetails());
                      },
                      child: CachedNetworkImage(
                        imageUrl: model.image,
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
                          ShopCubit.get(context).changeFavorites(model.id);
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
                  model.name,
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

                    // CircleAvatar(
                    //   radius: 18.0,
                    //   backgroundColor: Colors.grey,
                    //   child: IconButton(
                    //     //padding: EdgeInsets.zero,
                    //     onPressed: () {},
                    //     icon: Icon(Icons.add_shopping_cart_outlined),
                    //     iconSize: 16.0,
                    //     color: Colors.white,
                    //   ), ShopCubit.get(context).changeFavourite[model.id]!
                    // ? Icons.add_shopping_cart
                    // : Icons.add_shopping_cart_outlined
                    // ),
                    // SizedBox(
                    //   width: 5.0,
                    // ),
                    Spacer(),
                    customCartIcon(
                      text: 'Add Cart',
                      onTap: () {
                        ShopCubit.get(context).changeCarts(productId: model.id);
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
      );
  Widget customCategoriesItems(DataModel model, context) => InkWell(
        onTap: () {
          ShopCubit.get(context).getCategoryDetails(model.id!);
          Get.to(
            CategoryDetailsScreen(model.name),
          );
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    model.image!,
                  ),
                ),
                Image(
                  image: AssetImage(
                    'assets/images/categoryborder.png',
                  ),
                  width: 80.0,
                  height: 80.0,
                ),
              ],
            ),
            Container(
                width: 100.0,
                child: Text(
                  model.name!,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      );
}
