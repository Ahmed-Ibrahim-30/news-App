import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/Shared.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit myCubit=cubit.get(context);
    // myCubit.getSportNews();
    return BlocConsumer<cubit,States>(
      listener: (context,state){
        //print("state = $state");
        //print(myCubit.sportNews.length);
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition:myCubit.sportNews.isNotEmpty,
          builder:(context)=> newsApi(allNews: myCubit.sportNews),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
