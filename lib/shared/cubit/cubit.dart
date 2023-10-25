import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List<BottomNavigationBarItem> BottomItem = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  void changeBottomNav(int index) {
    CurrentIndex = index;
    emit(NewsChangeBottomNavBarState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    SciencsScreen(),
  ];

  List<dynamic> Business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '875b753f78a944d18c20e7f5a3ac37fa',
    }).then((value) {
      Business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'sports',
      'apiKey': '875b753f78a944d18c20e7f5a3ac37fa',
    }).then((value) {
      Sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> Science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'science',
      'apiKey': '875b753f78a944d18c20e7f5a3ac37fa',
    }).then((value) {
      Science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=875b753f78a944d18c20e7f5a3ac37fa
//   https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=875b753f78a944d18c20e7f5a3ac37fa

  bool isMode = true;

  void changeMode({bool? mode}) {
    if (mode != null) {
      isMode = mode;
      emit(NewsGetModeState());
    } else {
      isMode = !isMode;
      CacheHelper.putBool(Key: 'isMode', value: isMode).then((value) {
        emit(NewsGetModeState());
      });
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '875b753f78a944d18c20e7f5a3ac37fa',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
