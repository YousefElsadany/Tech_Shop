import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/ContactUsModel.dart';
import 'package:tech_shop/module/WebViewPage/WebViewScreen.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Text('Contact Us'),
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
          body: state is ShopLoadingGetSettingsState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/contactus.png',
                              width: 187.0,
                              height: 162.0,
                            ),
                            customLine(
                              margin: 35.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => buildContcts(
                                  ShopCubit.get(context)
                                      .contactUsModel!
                                      .data!
                                      .data[index],
                                  index,
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20.0,
                                ),
                                itemCount: 5,
                                //  ShopCubit.get(context)
                                //     .contactUsModel!
                                //     .data!
                                //     .data
                                //     .length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

List<String> titles = ['Facebook', 'Instigram', 'Twitter', 'Gmail', 'Phone'];
Widget buildContcts(ContactData model, index) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            Get.to(WebVeiwScreen(model.value!));
          },
          child: Row(
            children: [
              Image(
                image: NetworkImage(
                  model.image!,
                ),
                color: shopColor,
                width: 40.0,
                height: 40.0,
              ),
              SizedBox(
                width: 35.0,
              ),
              Text(
                titles[index],
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
