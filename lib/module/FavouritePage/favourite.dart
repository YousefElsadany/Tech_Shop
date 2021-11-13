import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/FavoriteModel.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';


class FavourietScreen extends StatelessWidget {
  const FavourietScreen({Key? key}) : super(key: key);

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
      },
      builder: (context, state) {
        return ShopCubit.get(context).favoriteModel!.data!.total == 0
            ? customEmptyPage(
                imagePath: 'assets/images/empty.png',
                width: 210.0,
                height: 187.0,
                text: 'Your Favorite list is empty .',
              )
            : ConditionalBuilder(
                condition: ShopCubit.get(context).favoriteModel != null,
                builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFavorite(
                      ShopCubit.get(context).favoriteModel!.data!.data![index],
                      context),
                  separatorBuilder: (context, index) => customLine(),
                  itemCount:
                      ShopCubit.get(context).favoriteModel!.data!.data!.length,
                ),
                fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: shopColor,
                )),
              );
      },
    );
  }
}

Widget buildFavorite(
  FavoritesData model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 146.0,
        //color: Colors.white,
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        //width: 150,
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
                if (model.product!.discount! != 0)
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
                        '\$ ${model.product!.price!}',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: shopColor),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.product!.discount! != 0)
                        Text(
                          model.product!.oldPrice!.toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      CircleAvatar(
                        radius: 18.0,
                        backgroundColor:
                            ShopCubit.get(context).favourite[model.product!.id]!
                                ? shopColor
                                : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id!);
                            // print(model.id.toString());
                          },
                          icon: Icon(Icons.favorite_border),
                          iconSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
