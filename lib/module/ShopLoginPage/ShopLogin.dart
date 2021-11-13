import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/ShopLayout.dart';
import 'package:tech_shop/module/RegisterPage/ShopRegister.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/componants/constants.dart';
import 'package:tech_shop/shared/network/local/CachHelper.dart';
import 'package:tech_shop/shared/style/colors.dart';

import 'Cubit/Cubit.dart';
import 'Cubit/States.dart';

class LoginShopScreen extends StatelessWidget {
  const LoginShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    //ShopLoginCubit loginCubit = ShopLoginCubit.get(context);
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              print(state.loginModel.data!.email);
              print(state.loginModel.data!.id);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                Get.offAll(ShopLayout());
                showTast(
                    text: state.loginModel.message, state: ToastStates.SUCCESS);
              });
            } else {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              showTast(
                  text: state.loginModel.message, state: ToastStates.ERROR);
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
            ),
            //backgroundColor: fullBackgroundColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/loginn.png',
                            width: 200.0,
                            height: 150.9,
                          ),
                        ),
                        Text(
                          'Welcome Back!',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Log in to your existant account of Q Allure',
                          //style: Theme.of(context).textTheme.subtitle2,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        customTextFeild(
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          title: 'Email Adress',
                          pIcon: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        customTextFeild(
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          title: 'Password',
                          pIcon: Icons.lock,
                          Submit: (value) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          },
                          isPassword: ShopLoginCubit.get(context).isShow,
                          sIcon: ShopLoginCubit.get(context).suffinx,
                          suffixPress: () {
                            ShopLoginCubit.get(context).changePasswordIcon();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password Required';
                            } else if (value.length < 6) {
                              return 'Password less than 6 charchtar ';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forget Your Password?',
                                  style: TextStyle(color: Colors.grey[800]),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => customButtom(
                              buttomCollor: shopColor,
                              buttomWidth: 150.0,
                              text: 'LOGIN',
                              press: () {
                                if (formKey.currentState!.validate()) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text('Processing Data')));
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          fallback: (context) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Loading',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.grey[400]),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircularProgressIndicator()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Or'),
                        Container(
                          //width: 150.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 140,
                                height: 42,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Color(0xff1877f2),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/facebook.png',
                                      width: 45.0,
                                      height: 40.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Facebook',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                width: 140,
                                height: 42,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  color: Color(0xffb23121),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/gmail.png',
                                      width: 40.0,
                                      height: 35.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Gmail',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account?'),
                            TextButton(
                                onPressed: () {
                                  Get.to(ShopRegisterScreen());
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: shopColor),
                                ))
                          ],
                        )
                      ],
                    ),
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
