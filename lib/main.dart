import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/module/ShopLoginPage/ShopLogin.dart';
import 'package:tech_shop/module/onBordingPage/onBording.dart';
import 'package:tech_shop/shared/Cubit/cubit.dart';
import 'package:tech_shop/shared/Cubit/states.dart';
import 'package:tech_shop/shared/componants/constants.dart';
import 'package:tech_shop/shared/network/local/CachHelper.dart';
import 'package:tech_shop/shared/network/remote/DioHelper.dart';
import 'package:tech_shop/shared/style/Themes.dart';
import 'layout/ShopApp/ShopLayout.dart';
import 'module/SearchPage/SearchCubit/SearchCubit.dart';
import 'shared/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  late bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  late bool? isBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  //(token!);
  if (isBoarding != null) {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginShopScreen();
    }
  } else {
    widget = OnBordingScreen();
  }
  runApp(MyApp(
    isDark: (isDark != null) ? isDark : false,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({required this.isDark, required this.startWidget});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorite()
            ..getCart()
            ..getProfile()
            ..getSettings()
            ..getFAQs()
            ..getContctUs()
            ..getAddresses(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: AppCubit.get(context).isDarke
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
