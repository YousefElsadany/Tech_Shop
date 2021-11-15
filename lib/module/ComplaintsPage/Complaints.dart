import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';


class Complaintscreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        nameController.text = cubit.profileModel!.data.name;
        phoneController.text = cubit.profileModel!.data.phone;
        emailController.text = cubit.profileModel!.data.email;
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            title: Text('Complaints'),
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/images/complaint.jpg'),
                          width: 150.0,
                          height: 170.0,
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'If you have any complaint about the application \n You are in the right place .',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        buildComplaintFeild(
                          text: 'Name',
                          controller: nameController,
                          inputType: TextInputType.name,
                          pIcon: Icons.person_outline,
                          title: 'Full Name',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        buildComplaintFeild(
                            text: 'Email',
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            pIcon: Icons.email_outlined,
                            title: 'Email',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email Required';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        buildComplaintFeild(
                            text: 'Phone',
                            controller: phoneController,
                            inputType: TextInputType.phone,
                            pIcon: Icons.phone_outlined,
                            title: 'Phone',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone Required';
                              } else if (value.length < 11) {
                                return 'Phone number must be at least 11 number';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        buildComplaintFeild(
                            text: 'Message',
                            controller: messageController,
                            inputType: TextInputType.text,
                            pIcon: Icons.message_outlined,
                            title: 'Message',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your message';
                              } else if (value.length > 500) {
                                return 'Message mustn\'t be more than 500 Characters';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 25.0,
                        ),
                        customButtom(
                          buttomCollor: shopColor,
                          text: 'SEND',
                          press: () {
                            if (formKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //         content: Text('Processing Data')));
                              ShopCubit.get(context).sendComplaints(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                message: messageController.text,
                              );
                              showTast(
                                text: ShopCubit.get(context)
                                    .complaintModel!
                                    .message,
                                state: ToastStates.SUCCESS,
                              );
                              Get.back();
                            }
                          },
                          buttomWidth: double.infinity,
                        ),
                      ],
                    ),
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

Widget buildComplaintFeild({
  required String text,
  required TextEditingController controller,
  required TextInputType inputType,
  required IconData pIcon,
  required String title,
  String? Function(String?)? validate,
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
          title: title,
          pIcon: pIcon,
          textColor: Colors.black,
          validate: validate,
          backgroundColor: Colors.white,
        )
      ],
    );
