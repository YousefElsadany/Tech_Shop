

import 'package:tech_shop/model/AddAderessModel.dart';
import 'package:tech_shop/model/ChangeCartModel.dart';
import 'package:tech_shop/model/ChangeFavoritesModel.dart';
import 'package:tech_shop/model/ProfileModel.dart';
import 'package:tech_shop/model/Update&DeleteModel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeNavBar extends ShopStates {}

class ShopHomeLoadingDataState extends ShopStates {}

class ShopHomeSuccessDataState extends ShopStates {}

class ShopHomeErrorDataState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavouritesModel? model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingsGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopChangeCartsState extends ShopStates {}

class ShopSuccessChangeCartsState extends ShopStates {
  final ChangeCartsModel? model;

  ShopSuccessChangeCartsState(this.model);
}

class ShopErrorChangeCartsState extends ShopStates {}

class ShopLoadingsGetCartsState extends ShopStates {}

class ShopSuccessGetCartsState extends ShopStates {}

class ShopErrorGetCartsState extends ShopStates {}

class ShopPlusQuantityState extends ShopStates {}

class ShopMinusQuantityState extends ShopStates {}

class ShopLoadingCountCartsState extends ShopStates {}

class ShopSuccessCountCartsState extends ShopStates {}

class ShopErrorCountCartsState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {}

class ShopErrorGetProfileState extends ShopStates {}

class ShopLoadingGetProductDetailsState extends ShopStates {}

class ShopSuccessGetProductDetailsState extends ShopStates {}

class ShopErrorGetProductDetailsState extends ShopStates {}

class ShopLoadingGetCategroyDetailsState extends ShopStates {}

class ShopSuccessGetCategroyDetailsState extends ShopStates {}

class ShopErrorGetCategroyDetailsState extends ShopStates {}

class ShopLoadingUpdateProfileState extends ShopStates {}

class ShopSuccessUpdateProfileState extends ShopStates {}

class ShopErrorUpdateProfileState extends ShopStates {}

class SuccessUploadPicState extends ShopStates {}

class ErrorUploadPicState extends ShopStates {}

class ShopLoadingGetSettingsState extends ShopStates {}

class ShopSuccessGetSettingsState extends ShopStates {}

class ShopErrorGetSettingsState extends ShopStates {}

class ShopLoadingGetFAQsState extends ShopStates {}

class ShopSuccessGetFAQsState extends ShopStates {}

class ShopErrorGetFAQsState extends ShopStates {}

class ShopLoadingGetContactUsState extends ShopStates {}

class ShopSuccessGetContactUsState extends ShopStates {}

class ShopErrorGetContactUsState extends ShopStates {}

class ShopLoadingSendComplaintsState extends ShopStates {}

class ShopSuccessSendComplaintsState extends ShopStates {}

class ShopErrorSendComplaintsState extends ShopStates {}

class ShopLoadingGetNotificationsState extends ShopStates {}

class ShopSuccessGetNotificationsState extends ShopStates {}

class ShopErrorGetNotificationsState extends ShopStates {}

class ShopLoadingAddAderessState extends ShopStates {}

class ShopSuccessAddAderessState extends ShopStates {
  final AddAddressModel addAddressModel;

  ShopSuccessAddAderessState(this.addAddressModel);
}

class ShopErrorAddAderessState extends ShopStates {}

class ShopLoadingAderessState extends ShopStates {}

class ShopSuccessAderessState extends ShopStates {}

class ShopErrorAderessState extends ShopStates {}

class ShopLoadingUpdateAderessState extends ShopStates {}

class ShopSuccessUpdateAderessState extends ShopStates {
  final UpdateAddressModel updateAddressModel;

  ShopSuccessUpdateAderessState(this.updateAddressModel);
}

class ShopErrorUpdateAderessState extends ShopStates {}

class ShopLoadingDeleteAderessState extends ShopStates {}

class ShopSuccessDeleteAderessState extends ShopStates {
  final UpdateAddressModel deleteAddressModel;

  ShopSuccessDeleteAderessState(this.deleteAddressModel);
}

class ShopErrorDeleteAderessState extends ShopStates {}
