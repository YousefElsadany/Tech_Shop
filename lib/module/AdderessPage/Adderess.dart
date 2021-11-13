import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/AderessModel.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';

import 'AddLocationPage/AddLocation.dart';

class Adderesscreen extends StatelessWidget {
  const Adderesscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AddressData? addressData;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Text('Adderess'),
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CircleAvatar(
                  backgroundColor: shopColor,
                  child: IconButton(
                    onPressed: () {
                      Get.to(AddLocationScreen(
                        isEdit: false,
                      ));
                    },
                    icon: Icon(
                      Icons.add_location_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: state is ShopLoadingAddAderessState ||
                  state is ShopLoadingUpdateAderessState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ShopCubit.get(context)
              .addressModel!
              .data!.total ==0?
          customEmptyPage(
            imagePath: 'assets/images/empty.png',
            width: 210.0,
            height: 187.0,
            text: 'Address Page is empty .',
          )
              :Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildLocationItem(
                            ShopCubit.get(context)
                                .addressModel!
                                .data!
                                .data[index],
                            context,
                          ),
                          separatorBuilder: (context, index) =>
                              customLine(margin: 12.0),
                          itemCount: ShopCubit.get(context)
                              .addressModel!
                              .data!
                              .data
                              .length,
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

Widget buildLocationItem(AddressData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: shopColor,

              radius: 30.0,

              child: Icon(
                Icons.location_city_outlined,
                size: 40,
                color: Colors.white,
              ),

              // Text(

              //   'Home',

              //   style: TextStyle(

              //     fontSize: 20.0,

              //     color: Colors.white,

              //   ),

              // ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${model.city} - ${model.region}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    model.details!,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    model.notes!,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(AddLocationScreen(
                      isEdit: true,
                      addressId: model.id,
                      name: model.name,
                      city: model.city,
                      region: model.region,
                      details: model.details,
                      notes: model.notes,
                    ));
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.edit_location_alt_outlined,
                          color: Colors.grey[600],
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        InkWell(
                          onTap: () {
                            ShopCubit.get(context)
                                .deleteAddress(addressId: model.id);
                            showTast(
                              text: ShopCubit.get(context)
                                  .deleteAddressModel!
                                  .message,
                              state: ToastStates.SUCCESS,
                            );
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
