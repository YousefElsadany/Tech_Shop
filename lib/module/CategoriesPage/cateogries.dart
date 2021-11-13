
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/CategoriesModel.dart';
import 'package:tech_shop/module/CategoryDetails/CategoryDetails.dart';
import 'package:tech_shop/shared/componants/componants.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingCategoriesState,
          builder: (context) => buildCategoriesList(context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// Widget customCategories(DataModel model) => Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 3),
//             ],
//           ),
//           child: CircleAvatar(
//             backgroundImage: NetworkImage(model.image!),
//             radius: 50.0,
//             foregroundColor: Colors.black,
//           ),
//         ),
//         Text(
//           model.name!,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.grey,
//           ),
//         )
//       ],
//     );
Widget buildCategoriesList(context) => ListView.separated(
      itemBuilder: (context, index) => customCategories(
          ShopCubit.get(context).categoriesModel!.data!.data[index], context),
      separatorBuilder: (context, index) => customLine(),
      itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
    );

Widget customCategories(DataModel model, context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      child: InkWell(
        onTap: () {
          ShopCubit.get(context).getCategoryDetails(model.id!);
          Get.to(
            CategoryDetailsScreen(model.name),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              //color: Colors.white,
              // borderRadius: BorderRadius.circular(10.0),
              // boxShadow: [
              //   BoxShadow(blurRadius: 3, color: Colors.grey, spreadRadius: 1),
              // ],
              ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(model.image!),
                    // child: Image(
                    //   image: NetworkImage(model.image!),
                    //   height: 100.0,
                    //   width: 100.0,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Image(
                    image: AssetImage(
                      'assets/images/categoryborder.png',
                    ),
                    width: 105.0,
                    height: 105.0,
                  ),
                ],
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                model.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
              // FloatingActionButton(
              //     onPressed: () {},
              //     elevation: 0.0,
              //     child: Icon(Icons.arrow_forward_ios))
            ],
          ),
        ),
      ),
    );
