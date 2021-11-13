import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/module/RegisterPage/Cubit/SignUpStates.dart';
import 'package:tech_shop/module/ShopLoginPage/ShopLogin.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';

import 'Cubit/SignUpCubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopSignUpCubit(),
      child: BlocConsumer<ShopSignUpCubit, ShopSignUpStates>(
        listener: (context, state) {
          if (state is ShopSignUpSuccesState) {
            if (state.signUpModel.status!) {
              print(state.signUpModel.status);
              print(state.signUpModel.message);
              Get.offAll(LoginShopScreen());
              Get.snackbar(
                'Sign Up',
                state.signUpModel.message,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            } else {
              print(state.signUpModel.status);
              print(state.signUpModel.message);
              Get.snackbar(
                'Sign Up',
                state.signUpModel.message,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined, color: shopColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Registration Form',
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              'Please enter the required information',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextFormFeilds(
                              controller: nameController,
                              title: 'Full Name',
                              lable: 'Example “ Mohamed Ibrahim”',
                              inputType: TextInputType.name,
                              pIcon: Icons.person_outline,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Full Name Required *';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 17.0,
                            ),
                            buildTextFormFeilds(
                              controller: emailController,
                              title: 'Email',
                              lable: 'Example “ user@example.com”',
                              inputType: TextInputType.emailAddress,
                              pIcon: Icons.email_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email Required *';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 17.0,
                            ),
                            buildTextFormFeilds(
                              controller: phoneController,
                              title: 'Phone Numbuer',
                              lable: 'Example “ 01099313888”',
                              inputType: TextInputType.phone,
                              pIcon: Icons.phone_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone Required *';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 17.0,
                            ),
                            buildTextFormFeilds(
                              controller: passwordController,
                              title: 'Password',
                              lable: '* * * * * * * *',
                              inputType: TextInputType.visiblePassword,
                              pIcon: Icons.lock,
                              // submit: (value) {
                              //   // ShopLoginCubit.get(context).userLogin(
                              //   //     email: emailController.text,
                              //   //     password: passwordController.text);
                              // },
                              sIcon: ShopSignUpCubit.get(context).suffinx,
                              isPassword: ShopSignUpCubit.get(context).isShow,
                              suffixPress: () {
                                ShopSignUpCubit.get(context)
                                    .changePasswordIcon();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password Required';
                                } else if (value.length < 6) {
                                  return 'Password less than 6 charchtar ';
                                }
                                //  else if (passwordController !=
                                //     confirmPasswordController) {
                                //   return 'Password is not same ';
                                // }
                                return null;
                              },
                            ),
                            // SizedBox(
                            //   height: 17.0,
                            // ),
                            // buildTextFormFeilds(
                            //   controller: confirmPasswordController,
                            //   title: 'Confirm Password',
                            //   lable: '* * * * * * * *',
                            //   inputType: TextInputType.visiblePassword,
                            //   pIcon: Icons.lock,
                            //   submit: (value) {
                            //     // ShopLoginCubit.get(context).userLogin(
                            //     //     email: emailController.text,
                            //     //     password: passwordController.text);
                            //   },
                            //   //isPassword: ShopLoginCubit.get(context).isShow,
                            //   //sIcon: ShopLoginCubit.get(context).suffinx,
                            //   suffixPress: () {
                            //     // ShopLoginCubit.get(context).changePasswordIcon();
                            //   },
                            //   validate: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Confirm Password Required';
                            //     } else if (value.length > 6) {
                            //       return 'Password is not same ';
                            //     }
                            //     // else if (confirmPasswordController !=
                            //     //     passwordController) {
                            //     //   return 'Password less than 6 charchtar ';
                            //     // }
                            //     return null;
                            //   },
                            // ),
                            SizedBox(
                              height: 35.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopSignUpLoadingState,
                              builder: (context) => customButtom(
                                  buttomCollor: shopColor,
                                  buttomWidth: double.infinity,
                                  text: 'Sign Up',
                                  press: () {
                                    if (formKey.currentState!.validate()) {
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(SnackBar(
                                      //         content:
                                      //             Text('Processing Data')));
                                      ShopSignUpCubit.get(context).userSignUp(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  }),
                              fallback: (context) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Loading',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.grey[400]),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  CircularProgressIndicator(
                                    color: shopColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildTextFormFeilds({
  required TextEditingController controller,
  required String title,
  required String lable,
  required TextInputType inputType,
  required IconData pIcon,
  bool isPassword = false,
  IconData? sIcon,
  required String? Function(String?)? validate,
  Function()? tap,
  String? Function(String?)? change,
  String? Function(String?)? submit,
  suffixPress,
}) =>
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          customTextFeild(
            controller: controller,
            inputType: inputType,
            title: lable,
            pIcon: pIcon,
            Submit: submit,
            isPassword: isPassword,
            sIcon: sIcon,
            suffixPress: suffixPress,
            validate: validate,
          ),
        ],
      ),
    );
