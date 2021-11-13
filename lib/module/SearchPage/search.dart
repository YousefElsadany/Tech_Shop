import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/model/SearchModel.dart';
import 'package:tech_shop/model/SearchModel.dart';
import 'package:tech_shop/module/ProductDetailsPage/ProductDetails.dart';
import 'package:tech_shop/module/SearchPage/SearchCubit/SearchCubit.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';

import 'SearchCubit/states.dart';

class SeachScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    SearchCubit cubit = SearchCubit.get(context);

    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Text('Search'),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: fullBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: fullBackgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: shopColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: state is LoadingSearchState
              ? Center(
            child: CircularProgressIndicator(),
          )
              :  Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        customTextFeild(
                          controller: searchController,
                          inputType: TextInputType.text,
                          title: 'Search',
                          backgroundColor: Colors.white,
                          pIcon: Icons.search,
                          Submit: (value){
                            cubit.getSearch(searchController.text);
                          }
                        ),
                        SizedBox(height: 15.0,),
                        cubit.searchModel != null?
                        searchController.text.isEmpty?
                        Container(): Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => searchItemBuilder(
                              cubit.searchModel!.data.data[index],
                                context,
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) => customLine(),
                            itemCount: cubit.searchModel!.data.data.length,
                          ),
                        ):
                        Container(),
                      ],
                    ),
                  ),
                ),
              )
        );
      },
    );
  }
}

Widget searchItemBuilder(SearchProduct? model,context,{
  bool isOldPrice = true,
}){
  return  InkWell(
    onTap: (){
      ShopCubit.get(context).getProductDetails(model!.id!);
      Get.to(ProductsDetails());
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [

                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 75.0,
                  child: CachedNetworkImage(

                    imageUrl: model!.image!,
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width: 95.0,
                    height: 95.0,
                    //fit: BoxFit.cover,
                  ),
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: shopColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favourite[model.id!]!
                              ? shopColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
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
    ),
  );
}

