import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/shared/style/colors.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Text('FAQs'),
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
          body: state is ShopLoadingGetFAQsState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/FAQs.png',
                            width: 349.0,
                            height: 227.0,
                          ),
                          Container(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => buildFAQs(
                                context: context,
                                question: ShopCubit.get(context)
                                    .faQsModel!
                                    .data!
                                    .data[index]
                                    .question,
                                answer: ShopCubit.get(context)
                                    .faQsModel!
                                    .data!
                                    .data[index]
                                    .answer,
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 5.0,
                              ),
                              itemCount: ShopCubit.get(context)
                                  .faQsModel!
                                  .data!
                                  .data
                                  .length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

Widget buildFAQs({context, String? question, String? answer}) => ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      title: Row(
        children: [
          Icon(Icons.question_answer_outlined),
          SizedBox(
            width: 5.0,
          ),
          Text(
            question!,
            //style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(answer!),
        ),
      ],
    );
