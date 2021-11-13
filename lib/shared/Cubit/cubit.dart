import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tech_shop/shared/Cubit/states.dart';
import 'package:tech_shop/shared/network/local/CachHelper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitalState());
  static AppCubit get(context) => BlocProvider.of(context);



  bool isDarke = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDarke = fromShared;
      emit(AppChangeMode());
    } else {
      isDarke = !isDarke;
      CacheHelper.putBool(key: 'isDark', value: isDarke).then((value) {
        emit(AppChangeMode());
      }).catchError((error) {
        print('ERROR******* ${error.toString()}');
      });
    }
  }
}
