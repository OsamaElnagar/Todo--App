import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
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
          background: Container(
            alignment: AlignmentDirectional.centerStart,
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(
                Icons.check,
                size: 30,
              ),
            ),
          ),
          secondaryBackground: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(
                Icons.cancel,
                size: 30,
              ),
            ),
          ),
          key: Key(model['id'].toString()),
          onDismissed: (direction) {
            cubit.deleteData(model['id']);
          },
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.blue),
                  ),
                  content: const Text(
                    "Are you sure you wish to delete this item?",
                    style: TextStyle(color: Colors.blue),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text(
                          "DELETE",
                          style: TextStyle(color: Colors.blue),
                        )),
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 48,
                      child: CircleAvatar(
                        radius: 45,
                        child: Text(
                          '${model['time']}',
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 170,
                            child: Text(
                              '${model['title']}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${model['date']}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    const SizedBox(),
                    if (states is AppNewTaskPositionState)
                      positionTransform(
                        model: model,
                        pressed1: () {
                          AppCubit.get(context).updateData('done', model['id']);
                        },
                        pressed2: () {
                          AppCubit.get(context)
                              .updateData('archived', model['id']);
                        },
                        icon1: const Icon(Icons.check_circle),
                        icon2: const Icon(Icons.archive),
                      ),
                    if (states is AppDoneTaskPositionState)
                      positionTransform(
                        model: model,
                        pressed1: () {
                          AppCubit.get(context).updateData('new', model['id']);
                        },
                        pressed2: () {
                          AppCubit.get(context)
                              .updateData('archived', model['id']);
                        },
                        icon1: const Icon(Icons.menu),
                        icon2: const Icon(Icons.archive),
                      ),
                    if (states is AppArchivedTaskPositionState)
                      positionTransform(
                        model: model,
                        pressed1: () {
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

Widget positionTransform(
    {required Map model,
    context,
    required Function() pressed1,
    required Function() pressed2,
    required Widget icon1,
    required Widget icon2}) {
  return BlocConsumer<AppCubit, AppStates>(
    listener: (context, states) {},
    builder: (context, states) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: AlignmentDirectional.topCenter,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: IconButton(
                onPressed: pressed1,
                icon: icon1,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: AlignmentDirectional.topCenter,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: IconButton(
                onPressed: pressed2,
                icon: icon2,
              ),
            ),
          ],
        ),
      );
    },
  );
}

void pint(String text) {
  debugPrint(text.toString());
}

void dialogMessage(
    {required BuildContext context,
    required Widget title,
    required Widget content,
    required List<Widget> actions}) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: title,
            content: content,
            actions: actions,
          ));
}

Random random = Random();

void generateToken() {
  pint(random.nextDouble().toString());
}
