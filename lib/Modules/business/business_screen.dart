import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';

import '../../component/Shared.dart';
import '../../cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     cubit myCubit=cubit.get(context);
     // myCubit.getBusinessNews();
    return BlocConsumer<cubit,States>(
        listener: (context,state){},
      builder: (context,state){
          return ConditionalBuilder(
              condition: myCubit.businessNews.isNotEmpty,
              builder:(context){
                print(myCubit.businessNews.length);
                return newsApi(allNews: myCubit.businessNews);
              },
              fallback: (context){
                print(myCubit.businessNews.length);
                return const Center(child: CircularProgressIndicator());
              },
          );

      },
    );
  }
}
