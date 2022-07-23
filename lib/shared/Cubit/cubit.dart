
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo1/shared/Cubit/states.dart';
import 'package:todo1/shared/network/remote/cache_helper.dart';
import '../../modules/archivedTaskScreen.dart';
import '../../modules/doneTaskScreen.dart';
import '../../modules/newTaskScreen.dart';
import '../network/local/components.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = ['New', 'Done', 'Archived'];

  void changeIndex(int index) {
    if (index == 0) {
      currentIndex = index;
      emit(AppChangeBottomNavState());
      emit(AppNewTaskPositionState());
    }
    if (index == 1) {
      currentIndex = index;
      emit(AppChangeBottomNavState());
      emit(AppDoneTaskPositionState());
    }
    if (index == 2) {
      currentIndex = index;
      emit(AppChangeBottomNavState());
      emit(AppArchivedTaskPositionState());
    }
  }

  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData('isDark', isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  late Database? database;

  void createDatabase() {
    openDatabase(
      'todo.db',
      onCreate: (Database database, int version) {
        pint('database created');
        database
            .execute(
          " Create TABLE Tasks(id INTEGER PRIMARY KEY,title TEXT,time TEXT, date TEXT,status TEXT)",
        )
            .then((value) {
          pint(' TABLE CREATED');
        }).catchError((onError) {
          pint(" Error While Creating TABLE ${onError.toString()}");
        });
      },
      onOpen: (database) {
        getFromDatabase(database);
        pint('database open');
      },
      version: 1,
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
      emit(AppNewTaskPositionState());
    });
  }

  Future<void> insertToDatabase(String title, String time, String date) {
    return database!.transaction((txn) async {
      return await txn
          .rawInsert(
        'INSERT INTO Tasks (title, time, date, status) VALUES("$title","$time","$date","new")',
      )
          .then((value) {
        pint('$value Inserted Successfully');
        getFromDatabase(database);
        emit(AppInsertDatabaseState());
      }).catchError((onError) {
        pint('Error While Inserting New Record${onError.toString()}');
      });
    });
  }

  void getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
      emit(AppNewTaskPositionState());
    });
  }

  updateData(String status, int id) async {
    database!.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  deleteData(id) async {
    database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState(bool isShow, IconData icon) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void emitAll() {
    emit(AppNewTaskPositionState());
  }
}
