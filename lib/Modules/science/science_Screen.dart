import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/Shared.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    cubit myCubit=cubit.get(context);
    // myCubit.getScienceNews();
    return BlocConsumer<cubit,States>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: myCubit.scienceNews.isNotEmpty,
          builder:(context)=> newsApi(allNews: myCubit.scienceNews),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
