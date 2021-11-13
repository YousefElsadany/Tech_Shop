import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_shop/model/LoginModel.dart';
import 'package:tech_shop/module/ShopLoginPage/Cubit/States.dart';
import 'package:tech_shop/shared/network/EndPoint.dart';
import 'package:tech_shop/shared/network/remote/DioHelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data['message']);
      print(loginModel!.data!.token);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print('ERROR LOGIN' + error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffinx = Icons.visibility;
  bool isShow = true;

  void changePasswordIcon() {
    isShow = !isShow;
    suffinx =
        isShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordIconState());
  }
}
