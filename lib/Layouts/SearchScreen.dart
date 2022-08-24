import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';

import '../component/Shared.dart';
import '../cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit myCubit=cubit.get(context);
    return BlocConsumer<cubit,States>(
      listener: (context,state){
        //print("state = $state");
      },
      builder: (context,state){

        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )
                    ),
                    onChanged: (value){
                      myCubit.searchNews.clear();
                      myCubit.getSearchNews(value);
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child:ConditionalBuilder(
                      condition: myCubit.searchNews.isNotEmpty,
                      builder:(context){
                        print(myCubit.searchNews.length);
                        return newsApi(allNews: myCubit.searchNews);
                      },
                      fallback: (context)=>const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
