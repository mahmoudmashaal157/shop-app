import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopping/local-services/cache_helper.dart';
import 'package:shopping/screens/bottom-nav-bar-layout/layout.dart';
import 'package:shopping/screens/login/login_screen.dart';
import 'package:shopping/web-services/dio_helper.dart';

import 'common-use/bloc_observer.dart';
import 'common-use/constants.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  token= await CacheHelper.getData(key: "token");

  BlocOverrides.runZoned(() {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: mainColor
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:mainColor,
          selectedItemColor: Colors.white
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: mainColor
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: mainColor
        )
      ),
      debugShowCheckedModeBanner: false,
      home:
      token==null?
      LoginScreen():
        Layout(),
    );
  }
}

