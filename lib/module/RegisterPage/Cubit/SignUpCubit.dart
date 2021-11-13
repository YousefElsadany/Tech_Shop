import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_shop/model/SignUpModel.dart';
import 'package:tech_shop/module/RegisterPage/Cubit/SignUpStates.dart';
import 'package:tech_shop/shared/network/EndPoint.dart';
import 'package:tech_shop/shared/network/remote/DioHelper.dart';


class ShopSignUpCubit extends Cubit<ShopSignUpStates> {
  ShopSignUpCubit() : super(ShopSignUpInitialStates());

  static ShopSignUpCubit get(context) => BlocProvider.of(context);

  SignUpModel? signUpModel;

  void userSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopSignUpLoadingState());
    DioHelper.postData(
      url: SIGNUP,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      signUpModel = SignUpModel.fromJson(value.data);
      print(signUpModel!.message);
      print(value.data.toString());
      emit(ShopSignUpSuccesState(signUpModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopSignUpErrorState(error));
    });
  }

  IconData suffinx = Icons.visibility;
  bool isShow = true;

  void changePasswordIcon() {
    isShow = !isShow;
    suffinx = isShow ? Icons.visibility : Icons.visibility_off;
    emit(ShopSignUpChangePasswordIconState());
  }
}
