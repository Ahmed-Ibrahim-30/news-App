import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Layouts/SearchScreen.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,States>(
      listener: (context, state) {
       // print("Home State = $state");
      },
      builder: (context,state) {
        var myCubit=cubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              IconButton(onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const SearchScreen())
                );
              }, icon: const Icon(Icons.search)),
              IconButton(onPressed: (){
                myCubit.changeMode(!myCubit.isLightMode);
              }, icon: const Icon(Icons.brightness_6_outlined)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: myCubit.currentIndex,
              items: myCubit.bottoms,
              onTap: (index) {
                myCubit.changeBottomNavigationBar(index);
              }
          ),
          body: Directionality( textDirection: TextDirection.rtl,child: myCubit.Screens[myCubit.currentIndex]),
        );
      }
    );
  }
}
