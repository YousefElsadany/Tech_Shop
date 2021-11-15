import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/AddAderessModel.dart';
import 'package:tech_shop/model/AderessModel.dart';
import 'package:tech_shop/model/CartModel.dart';
import 'package:tech_shop/model/CategoriesDetailsModel.dart';
import 'package:tech_shop/model/CategoriesModel.dart';
import 'package:tech_shop/model/ChangeCartModel.dart';
import 'package:tech_shop/model/ChangeFavoritesModel.dart';
import 'package:tech_shop/model/ComplaintModel.dart';
import 'package:tech_shop/model/ContactUsModel.dart';
import 'package:tech_shop/model/FAQsModel.dart';
import 'package:tech_shop/model/FavoriteModel.dart';
import 'package:tech_shop/model/LoginModel.dart';
import 'package:tech_shop/model/NotificationsModel.dart';
import 'package:tech_shop/model/ProductDetailsModel.dart';
import 'package:tech_shop/model/ProfileModel.dart';
import 'package:tech_shop/model/SearchModel.dart';
import 'package:tech_shop/model/SettingsModel.dart';
import 'package:tech_shop/model/ShopModel.dart';
import 'package:tech_shop/model/Update&DeleteModel.dart';
import 'package:tech_shop/module/CategoriesPage/cateogries.dart';
import 'package:tech_shop/module/FavouritePage/favourite.dart';
import 'package:tech_shop/module/HomePage/Home.dart';
import 'package:tech_shop/module/SettingsPage/Settings.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/componants/constants.dart';
import 'package:tech_shop/shared/network/EndPoint.dart';
import 'package:tech_shop/shared/network/remote/DioHelper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    HomeScreen(),
    CateogriesScreen(),
    FavourietScreen(),
    SettingsScreen(),
  ];

  List<IconData> bottomsIcons = [
    Icons.home_outlined,
    Icons.widgets_outlined,
    Icons.favorite_border,
    Icons.settings_outlined,
  ];

  void changeNavBar(index) {
    currentIndex = index;
    emit(ShopChangeNavBar());
  }

  Map<int, bool> favourite = {};

  Map<int, bool> cart = {};

  File? profileImage;
  var picker = ImagePicker();
  Response? response;

  Future<dynamic> uploadProfileImage(
  {
    String? name,
    String? phone,
    String? email,
    String? image,
  }
      ) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'email': email,
      'image': await MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path,
      ),
    });
    if (pickedFile != null) {

       response = await DioHelper.postData(
        url: PROFILE,
        token: token,
        data: formData as Map<String,dynamic>,
       );
       profileImage =File(pickedFile.path);
      // if(response.statusCode==200){
      //   showTast(text:  "Gates are open########", state: ToastStates.ERROR);
      //
      // }
      print(pickedFile.path);
      emit(SuccessUploadPicState());
    } else {
      print('No image selected.');
      emit(ErrorUploadPicState());
    }
    // return DioHelper.putData(url: UPDATEPROFILE, data: {'image': image});
  }

  // void getProfileImage({
  //   String? name,
  //   String? phone,
  //   String? email,
  //   String? image,
  // }) {
  //   emit(ShopLoadingGetProfileState());
  //
  //   DioHelper.postData(url: PROFILE, data: {
  //     'name': name,
  //     'phone': phone,
  //     'email': email,
  //     'image': image,
  //   }).then((value) {
  //     profileModel = ProfileModel.fromJson(value.data);
  //     emit(ShopSuccessGetProfileState());
  //     }).catchError((error) {
  //       emit(ShopErrorGetProfileState());
  //     });
  // }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopHomeLoadingDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners![1].id);
      // print(homeModel!.status);

      homeModel!.data.products.forEach((element) {
        favourite.addAll({
          element.id: element.inFavorites,
        });
        //print(favourite.toString());
        //print(homeModel!.data!.products[1]);
      });
      homeModel!.data.products.forEach((element) {
        cart.addAll({
          element.id: element.inCart,
        });
        //print(cart.toString());
        //print(homeModel!.data!.products[1]);
      });
      //print(DioHelper.dio!.options.headers.toString());
      emit(ShopHomeSuccessDataState());
    }).catchError((error) {
      printFullText('ERROR DATA ' + error.toString());
      //print(DioHelper.dio!.options.headers.toString());
      emit(ShopHomeErrorDataState());
    });
  }

  ProfileModel? profileModel;

  void getProfile() {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then(
      (value) {
        profileModel = ProfileModel.fromJson(value.data);
        emit(ShopSuccessGetProfileState());
        print(profileModel!.data.token);
      },
    ).catchError(
      (error) {
        printFullText('ERROR PROFILE' + error.toString());
        emit(ShopErrorGetProfileState());
      },
    );
  }

  ShopLoginModel? loginModel;
  void updateProfile({
    String? name,
    String? phone,
    String? email,
    String? image,
  }) {
    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      },
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print('Update Profile ' + profileModel!.status.toString());
     // emit(ShopSuccessUpdateProfileState(profileModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateProfileState());
      printFullText('ERROR UPDATE PROFILE ' + error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      printFullText('ERROR DATA ' + error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavouritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favourite[productId] = !favourite[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVOURITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavouritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favourite[productId] = !favourite[productId]!;
      } else {
        getFavorite();
      }
      print('Success Favorite' + value.data.toString());
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favourite[productId] = !favourite[productId]!;
      printFullText('ERROR Change Favorites ' + error.toString());
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorite() {
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      //printFullText('SUCCESS FAVORITES' + value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('ERROR FAVORITES' + error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ChangeCartsModel? changeCartsModel;

  void changeCarts({required int productId}) {
    cart[productId] = !cart[productId]!;
    emit(ShopChangeCartsState());
    DioHelper.postData(
      url: CARTS,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeCartsModel = ChangeCartsModel.fromJson(value.data);
      if (!changeCartsModel!.status!) {
        cart[productId] = !cart[productId]!;
      } else {
        getCart();
      }
      //print('Success Carts' + value.data.toString());
      emit(ShopSuccessChangeCartsState(changeCartsModel));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      printFullText('ERROR Change Carts ' + error.toString());
      emit(ShopErrorChangeCartsState());
    });
  }

  CartModel? cartModel;

  void getCart() {
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      //printFullText('SUCCESS CARTS ' + value.data.toString());

      emit(ShopSuccessGetCartsState());
    }).catchError((error) {
      printFullText('ERROR CARTS ' + error.toString());
      emit(ShopErrorGetCartsState());
    });
  }

  int quantity = 1;

  void plusQuantity(CartModel model, index) {
    quantity = model.data!.cartItems[index].quantity!;
    quantity++;
    emit(ShopPlusQuantityState());
  }

  void minusQuantity(CartModel model, index) {
    quantity = model.data!.cartItems[index].quantity!;
    if (quantity > 1) quantity--;
    emit(ShopMinusQuantityState());
  }

  void updateCartData({
    required String id,
    int? quantity,
  }) {
    //emit(ShopLoadingCountCartsState());
    DioHelper.putData(
      url: '${UPDATECARTS + id}',
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value) {
      emit(ShopSuccessCountCartsState());
      getCart();
    }).catchError((error) {
      printFullText('ERROR UPDATE CARTS DATA' + error.toString());
      emit(ShopErrorCountCartsState());
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(int productId) {
    productDetailsModel = null;
    emit(ShopLoadingGetProductDetailsState());
    DioHelper.getData(
      url: PRODUCTDETAILS + productId.toString(),
      token: token,
    ).then(
      (value) {
        productDetailsModel = ProductDetailsModel.fromJson(value.data);
        print(
            'SUCCESS PRODUCT DETAILS' + productDetailsModel!.status.toString());
        emit(ShopSuccessGetProductDetailsState());
      },
    ).catchError(
      (error) {
        emit(ShopErrorGetProductDetailsState());
        printFullText('ERROR PRODUCT DETAILS' + error.toString());
      },
    );
  }

  CategoryDetailModel? categoryDetailModel;

  void getCategoryDetails(int categoryId) {
    emit(ShopLoadingGetCategroyDetailsState());
    DioHelper.getData(
      url: CATEGORYDETAILS + categoryId.toString(),
    ).then(
      (value) {
        categoryDetailModel = CategoryDetailModel.fromJson(value.data);
        print('SUCCESS Categroy DETAILS' +
            categoryDetailModel!.status.toString());
        emit(ShopSuccessGetCategroyDetailsState());
      },
    ).catchError(
      (error) {
        emit(ShopErrorGetCategroyDetailsState());
        printFullText('ERROR PRODUCT DETAILS' + error.toString());
      },
    );
  }

  SettingsModel? settingsModel;

  void getSettings() {
    emit(ShopLoadingGetSettingsState());
    DioHelper.getData(
      url: SETTINGS,
    ).then((value) {
      settingsModel = SettingsModel.fromJson(value.data);
      emit(ShopSuccessGetSettingsState());
    }).catchError((error) {
      printFullText('ERROR SETTINGS ' + error.toString());
      emit(ShopErrorGetSettingsState());
    });
  }

  FAQsModel? faQsModel;

  void getFAQs() {
    emit(ShopLoadingGetFAQsState());
    DioHelper.getData(
      url: FAQS,
    ).then((value) {
      faQsModel = FAQsModel.fromJson(value.data);
      emit(ShopSuccessGetFAQsState());
    }).catchError((error) {
      printFullText('ERROR FAQS ' + error.toString());
      emit(ShopErrorGetFAQsState());
    });
  }

  ContactUsModel? contactUsModel;

  void getContctUs() {
    emit(ShopLoadingGetContactUsState());
    DioHelper.getData(
      url: CONTACT,
    ).then((value) {
      contactUsModel = ContactUsModel.fromJson(value.data);
      emit(ShopSuccessGetContactUsState());
    }).catchError((error) {
      printFullText('ERROR ContactUS ' + error.toString());
      emit(ShopErrorGetContactUsState());
    });
  }

  ComplaintModel? complaintModel;

  void sendComplaints({
    required String name,
    required String phone,
    required String email,
    required String message,
  }) {
    DioHelper.postData(
      url: COMPLAINT,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'message': message,
      },
    ).then((value) {
      complaintModel = ComplaintModel.fromJson(value.data);
      printFullText('SECCES SEND COMPLAINT ' + complaintModel!.message!);
      emit(ShopSuccessSendComplaintsState());
    }).catchError((error) {
      printFullText('ERROR SEND COMPLAINT ' + error.toString());
      emit(ShopErrorSendComplaintsState());
    });
  }

  NotificationsModel? notificationsModel;

  void getNotifications() {
    emit(ShopLoadingGetNotificationsState());
    DioHelper.getData(
      url: NOTIFICATIONS,
      token: token,
    ).then((value) {
      notificationsModel = NotificationsModel.fromJson(value.data);
      emit(ShopSuccessGetNotificationsState());
    }).catchError((error) {
      printFullText('ERROR Notifications ' + error.toString());
      emit(ShopErrorGetNotificationsState());
    });
  }

  AddAddressModel? addAddressModel;

  void addAdderess({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLoadingAddAderessState());
    DioHelper.postData(
      url: ADDERESS,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
      token: token,
    ).then((value) {
      addAddressModel = AddAddressModel.fromJson(value.data);
      print('Success add adderess' + addAddressModel!.message!);
      if (addAddressModel!.status)
        getAddresses();
      else
        showTast(text: addAddressModel!.message, state: ToastStates.ERROR);
      emit(ShopSuccessAddAderessState(addAddressModel!));
    }).catchError((error) {
      printFullText('ERROR ADD Adderess' + error.toString());
      emit(ShopErrorAddAderessState());
    });
  }

  AddressModel? addressModel;
  void getAddresses() {
    emit(ShopLoadingAderessState());
    DioHelper.getData(
      url: ADDERESS,
      token: token,
    ).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      print('Get Addresses ' + addressModel!.status.toString());
      emit(ShopSuccessAderessState());
    }).catchError((error) {
      emit(ShopErrorAddAderessState());
      print(error.toString());
    });
  }

  UpdateAddressModel? updateAddressModel;

  void updateAdress({
    required int? addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLoadingUpdateAderessState());
    DioHelper.putData(
      url: '${UPDATE_DELETE_ADDRESS + addressId.toString()}',
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
      token: token,
    ).then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      print('Update Address' + updateAddressModel!.message!);
      if (updateAddressModel!.status) getAddresses();
      emit(ShopSuccessUpdateAderessState(updateAddressModel!));
    }).catchError((error) {
      printFullText('Error Update Address' + error.toString());
      emit(ShopErrorUpdateAderessState());
    });
  }

  UpdateAddressModel? deleteAddressModel;
  void deleteAddress({required addressId}) {
    emit(ShopLoadingDeleteAderessState());
    DioHelper.deleteData(
      url: '${UPDATE_DELETE_ADDRESS + addressId.toString()}',
      token: token,
    ).then((value) {
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      print('delete Address ' + deleteAddressModel!.status.toString());
      if (deleteAddressModel!.status) getAddresses();
      emit(ShopSuccessDeleteAderessState(deleteAddressModel!));
    }).catchError((error) {
      emit(ShopErrorDeleteAderessState());
      print(error.toString());
    });
  }

}
