import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/Layouts/SearchScreen.dart';
import 'package:newsapp/component/sharedpreference.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/network/dio_helper.dart';

import 'Layouts/HomeScreen.dart';
import 'cubit/BlocObserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Cache.init();
  BlocOverrides.runZoned(() {runApp(const MyApp());},
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
   const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>cubit()..getBusinessNews()..getScienceNews()..getSportNews(),
      child: BlocConsumer<cubit,States>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit myCubit=cubit.get(context);
          return MaterialApp(
              debugShowCheckedModeBanner:false,
              themeMode: myCubit.mode,
            darkTheme: ThemeData(
              textTheme: const TextTheme(
                headline1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70
                )
              ),
              scaffoldBackgroundColor: HexColor("#3F3A39"),
              appBarTheme:  AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarColor: HexColor("#3F3A39"),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor("#78747A"),
                  elevation: 5.0,
                  titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26
                  ),
                  iconTheme: const IconThemeData(
                      color: Colors.white,
                      size: 30
                  )
              ),
              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor("#78747A"),
                  selectedItemColor: Colors.tealAccent.withOpacity(0.9),
                  unselectedItemColor: Colors.black,
                  elevation: 10
              ),
            ),
            theme: ThemeData(
                textTheme: const TextTheme(
                    headline1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    )
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.light,
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 7.0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.black,
                        size: 30
                    )
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.green,
                    elevation: 30
                )
            ),
            home: const HomeScreen()
        );}
      ),
    );



  }
}
