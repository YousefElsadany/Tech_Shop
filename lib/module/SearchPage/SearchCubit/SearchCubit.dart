import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/model/SearchModel.dart';
import 'package:tech_shop/module/SearchPage/SearchCubit/states.dart';
import 'package:tech_shop/shared/componants/constants.dart';
import 'package:tech_shop/shared/network/EndPoint.dart';
import 'package:tech_shop/shared/network/remote/DioHelper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearch(String searchText){
    emit(LoadingSearchState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':'$searchText',
        }
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      print('Search Success '+searchModel!.status.toString());
      emit(SuccessSearchState());
    }).catchError((error){
      emit(ErrorSearchState());
      print('ERROR SEARCH '+error.toString());
    });
  }
}
