import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Modules/sport/sport_screen.dart';
import 'package:newsapp/cubit/states.dart';
import '../Modules/business/business_screen.dart';
import '../Modules/science/science_Screen.dart';
import '../component/sharedpreference.dart';
import '../network/dio_helper.dart';


//category=sports&country=eg
class cubit extends Cubit<States>{
  cubit():super(initState());
  static cubit get(context)=>BlocProvider.of(context);

  int currentIndex=Cache.getInt(key:'bottomNavigationBarIndex')??0;
  bool isLightMode=Cache.getMode(key: 'Mode') ?? true;
  late ThemeMode mode= isLightMode?ThemeMode.light:ThemeMode.dark;

  List<dynamic>businessNews=[];
  List<dynamic>scienceNews=[];
  List<dynamic>sportNews=[];
  List<dynamic>searchNews=[];

  List<BottomNavigationBarItem>bottoms=[
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'business'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science
      ),
        label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports
      ),
      label: 'Sport',
    ),
  ];

  List<Widget>Screens=[
    const BusinessScreen(),
    const ScienceScreen(),
    const SportScreen(),
  ];
  void changeBottomNavigationBar(int index){
    currentIndex=index;
    Cache.setInt(key: 'bottomNavigationBarIndex', value: currentIndex);
    emit(ChangeButtonNavigationState());
  }
  void changeMode(bool value){
    isLightMode=value;
    Cache.setMode(key: 'Mode', value: isLightMode);
    if(isLightMode) {
      mode=ThemeMode.light;
    } else {
      mode=ThemeMode.dark;
    }
    emit(ChangeModeState());
  }
  void getBusinessNews(){
    emit(GetBusinessNewsLoadingState());
    DioHelper.getData(
        url: "v1/news",
        query:{
          //keywords=tennis&countries=us,gb,de
          'countries':['eg','us'],
          'categories':'business',
          'access_key':'392ea720042261e41e62c159824b031b',
        }
    ).then((value) {
      //print(value.data['articles'][8]['author']);
      businessNews=value.data['data'];
      //print("length = ${businessNews.length}");
      emit(GetBusinessNewsSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(GetBusinessNewsErrorState());
    }
    );
  }
  void getScienceNews(){
    emit(GetScienceNewsLoadingState());
    DioHelper.getData(
        url: "v1/news",
        query:{
          'languages':'ar',
          'access_key':'392ea720042261e41e62c159824b031b',
        }
    ).then((value) {
      //print(value.data['articles'][8]['author']);
      scienceNews=value.data['data'];
      emit(GetScienceNewsSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(GetScienceNewsErrorState());
    }
    );
  }
  void getSportNews(){
    emit(GetSportNewsLoadingState());
    DioHelper.getData(
        url: "v1/news",
        query:{
          'languages':'en',
          //'countries':'us',
          'categories':'sports',
          'access_key':'392ea720042261e41e62c159824b031b',
        }
    ).then((value) {
      //print(value.data['articles'][8]['author']);
      sportNews=value.data['data'];
      emit(GetSportNewsSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(GetSportNewsErrorState());
    }
    );
  }
  void getSearchNews(String value){
    emit(GetSearchNewsLoadingState());
    DioHelper.getData(
        url: "v1/news",
        query:{
          'keywords':value,
          'access_key':'392ea720042261e41e62c159824b031b',
        }
    ).then((value) {
      print(searchNews.length);
      searchNews=value.data['data'];
      emit(GetSearchNewsSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(GetSearchNewsErrorState());
    }
    );
  }
}

