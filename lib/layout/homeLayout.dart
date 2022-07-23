import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo1/shared/Cubit/cubit.dart';
import 'package:todo1/shared/Cubit/states.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo1/shared/network/local/components.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  @override
  void initState() {

    //AppCubit.get(context).emit(AppNewTaskPositionState());
    super.initState();
  }
  @override
  dispose() {
    titleController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: AppCubit.get(context).isDark
                    ? const Icon(
                        Icons.brightness_3_sharp,
                      )
                    : const Icon(
                        Icons.lens_blur,
                      ),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()){
                  cubit.insertToDatabase(
                    titleController.text,
                    timeController.text,
                    dateController.text,
                  );
                  titleController.text=
              timeController.text=
              dateController.text='';
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' title must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(

                                  ),
                                  hoverColor: Colors.black,
                                  focusColor:  Colors.black,
                                  label: const Text('title'),
                                  prefixIcon: Icon(
                                    Icons.title,
                                    color: HexColor('#082144'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextFormField(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                controller: timeController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  pint(TimeOfDay.now().toString());
                                  if (value!.isEmpty) {
                                    return timeController.text =TimeOfDay.now().format(context).toString();

                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: const Text('time'),
                                  prefixIcon: Icon(
                                    Icons.watch_later,
                                    color: HexColor('#082144'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextFormField(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2022-08-15'),
                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                controller: dateController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return dateController.text = DateFormat.yMMMd().format(DateTime.now()).toString();

                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: const Text('date'),
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: HexColor('#082144'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(
                    false,
                    Icons.edit,
                  );
                });
                cubit.changeBottomSheetState(
                  true,
                  Icons.add,
                );
              }
            },
            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.storage_rounded,
                ),
                label: 'NEW',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'DONE',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive,
                ),
                label: 'ARCHIVED',
              ),
            ],
          ),
        );
      },
    );
  }
}
// tasks.isEmpty
// ? const Center(child: CircularProgressIndicator())
// : cubit.
