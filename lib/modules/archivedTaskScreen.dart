import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo1/shared/Cubit/cubit.dart';
import 'package:todo1/shared/Cubit/states.dart';
import '../shared/network/local/components.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return conditionalTaskBuilder(tasks);
      },
    );
  }
}
