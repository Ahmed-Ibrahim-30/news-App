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

  String url='v1/latest-news';
  String columnName='news';

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
        url: url,
        query:{
           'category':'business',
          'apiKey':'eXTk8eKNMv_GmiufuRQLn_8VBF4UdAB8SJR_3Wm7xlrB7Ow_',
        }
    ).then((value) {
      businessNews=value.data[columnName];
      emit(GetBusinessNewsSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(GetBusinessNewsErrorState());
    }
    );
  }
  void getScienceNews(){
    emit(GetScienceNewsLoadingState());
    DioHelper.getData(
        url: url,
        query:{
          'category':'science',
          'apiKey':'eXTk8eKNMv_GmiufuRQLn_8VBF4UdAB8SJR_3Wm7xlrB7Ow_',
        }
    ).then((value) {
      scienceNews=value.data[columnName];
      emit(GetScienceNewsSuccessState());
    }).catchError((onError){
      emit(GetScienceNewsErrorState());
    }
    );
  }
  void getSportNews(){
    emit(GetSportNewsLoadingState());
    DioHelper.getData(
        url: url,
        query:{
          'category':'sports',
          'apiKey':'eXTk8eKNMv_GmiufuRQLn_8VBF4UdAB8SJR_3Wm7xlrB7Ow_',
        }
    ).then((value) {
      //print(value.data['articles'][8]['author']);
      sportNews=value.data[columnName];
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
        url: 'v1/search',
        query:{
          'keywords':value,
          'apiKey':'eXTk8eKNMv_GmiufuRQLn_8VBF4UdAB8SJR_3Wm7xlrB7Ow_',
        }
    ).then((value) {
      //print(searchNews.length);
      searchNews=value.data[columnName];
      emit(GetSearchNewsSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(GetSearchNewsErrorState());
    }
    );
  }
}

