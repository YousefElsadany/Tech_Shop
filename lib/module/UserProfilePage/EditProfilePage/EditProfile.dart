import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';

class EditProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //TextEditingController imageController = TextEditingController();
  //dynamic imageController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        nameController.text = cubit.profileModel!.data.name;
        phoneController.text = cubit.profileModel!.data.phone;
        emailController.text = cubit.profileModel!.data.email;
        var profileImage = ShopCubit.get(context).profileImage;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: profileColor,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: profileColor,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (cubit.profileModel!.status == true) {
                      ShopCubit.get(context).updateProfile(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        //image: profileImage!.path.toString(),
                      );
                      Get.back();
                      showTast(
                          text: 'Update Success', state: ToastStates.SUCCESS);
                    } else {
                      showTast(
                          text: 'Some Thing is wrong',
                          state: ToastStates.SUCCESS);
                    }
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    color: profileColor,
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(
                                      cubit.profileModel!.data.image,
                                    )
                                  : FileImage(profileImage, scale: 1.0)
                                      as ImageProvider,
                            ),
                            InkWell(
                              onTap: () {
                                ShopCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                );

                              },
                              child: CircleAvatar(
                                radius: 18.0,
                                backgroundColor: shopColor,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        buildEditFeild(
                          text: 'Username',
                          controller: nameController,
                          inputType: TextInputType.name,
                          pIcon: Icons.person_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        buildEditFeild(
                          text: 'Email',
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          pIcon: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        buildEditFeild(
                          text: 'Phone',
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          pIcon: Icons.phone_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildEditFeild({
  required String text,
  required TextEditingController controller,
  required TextInputType inputType,
  required IconData pIcon,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        customTextFeild(
          controller: controller,
          inputType: inputType,
          title: '',
          pIcon: pIcon,
          textColor: Colors.black,
        )
      ],
    );
