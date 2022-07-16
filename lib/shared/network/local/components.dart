import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo1/shared/Cubit/cubit.dart';
import 'package:todo1/shared/Cubit/states.dart';

Widget ItemBuilder(Map model, context) => BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = AppCubit.get(context);
        return Dismissible(
          key: Key(model['id'].toString()),
          onDismissed: (direction) {
            AppCubit.get(context).deleteData(model['id']);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 4.0,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 45,
                        child: Text(
                          '${model['time']}',
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model['title']}',
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${model['date']}',
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    if (states is AppNewTaskPositionState)
                      positionTransform(
                        model: model,
                        pressed1: (){
                          AppCubit.get(context).updateData('done', model['id']);
                        },
                        pressed2: () {
                          AppCubit.get(context).updateData('archived', model['id']);
                        },
                        icon1: const Icon(Icons.check_circle),
                        icon2: const Icon(Icons.archive),
                      ),
                    if (states is AppDoneTaskPositionState)
                    positionTransform(
                      model: model,
                      pressed1: (){
                        AppCubit.get(context).updateData('new', model['id']);
                      },
                      pressed2: () {
                        AppCubit.get(context).updateData('archived', model['id']);
                      },
                      icon1: const Icon(Icons.menu),
                      icon2: const Icon(Icons.archive),
                    ),
                    if (states is AppArchivedTaskPositionState)
                      positionTransform(
                        model: model,
                        pressed1: (){
                          AppCubit.get(context).updateData('done', model['id']);
                        },
                        pressed2: () {
                          AppCubit.get(context).updateData('new', model['id']);
                        },
                        icon1: const Icon(Icons.check_circle),
                        icon2: const Icon(Icons.menu),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

Widget conditionalTaskBuilder(List<Map> tasks) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.storage_rounded,
              size: 50.0,
              color: Colors.grey[800],
            ),
            Text(
              'No tasks yet, Hit the button to add some!',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => ItemBuilder(tasks[index], context),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: tasks.length),
    );

Widget positionTransform({
  required Map model,
  context,
  required Function() pressed1,
  required Function() pressed2,
  required Widget icon1,
  required Widget icon2,
}) {
  return BlocConsumer<AppCubit, AppStates>(
    listener: (context, states) {},
    builder: (context, states) {
      return Row(
        children: [
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: IconButton(
              onPressed: pressed1,
              icon: icon1,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: IconButton(
              onPressed: pressed2,
              icon: icon2,
            ),
          ),
        ],
      );
    },
  );
}
