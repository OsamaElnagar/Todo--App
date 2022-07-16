import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo1/shared/network/local/blocObserver.dart';
import 'layout/homeLayout.dart';

void main() {

  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
