import 'package:tech_shop/model/SignUpModel.dart';

abstract class ShopSignUpStates {}

class ShopSignUpInitialStates extends ShopSignUpStates {}

class ShopSignUpChangePasswordIconState extends ShopSignUpStates {}

class ShopSignUpLoadingState extends ShopSignUpStates {}

class ShopSignUpSuccesState extends ShopSignUpStates {
  final SignUpModel signUpModel;

  ShopSignUpSuccesState(this.signUpModel);
}

class ShopSignUpErrorState extends ShopSignUpStates {
  final String error;

  ShopSignUpErrorState(this.error);
}
