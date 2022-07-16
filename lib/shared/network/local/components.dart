import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo1/shared/Cubit/cubit.dart';

Widget ItemBuilder(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),

      onDismissed: (direction)
      {
        AppCubit.get(context).deleteData(model['id']);
      },

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 45,
              child: Text(
                '${model['time']}',
                style: const TextStyle(
                  fontSize: 20.0,
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
              width: 18.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  'done',
                  model['id'],
                );
              },
              icon: const Icon(Icons.check_circle_outline),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  'archive',
                  model['id'],
                );
              },
              icon: const Icon(
                Icons.archive_outlined,
              ),
            ),
          ],
        ),
      ),
    );
Widget conditionalTaskBuilder(List<Map> tasks)=>ConditionalBuilder(
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
      itemBuilder: (context, index) =>
          ItemBuilder(tasks[index], context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Container(
          width: double.infinity,
          height: 2,
          color: Colors.grey[300],
        ),
      ),
      itemCount: tasks.length),
);