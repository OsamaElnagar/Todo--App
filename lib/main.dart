import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo1/shared/Cubit/cubit.dart';
import 'package:todo1/shared/Cubit/states.dart';
import 'package:todo1/shared/network/local/blocObserver.dart';
import 'package:todo1/shared/network/remote/cache_helper.dart';
import 'package:todo1/shared/styles/themes.dart';
import 'layout/homeLayout.dart';
import 'modules/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? isDark = await CacheHelper.getData(key: 'isDark');
  BlocOverrides.runZoned(
    () {
      runApp(
        MyApp(isDark: isDark),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..createDatabase()
        ..changeAppMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: AnimatedSplashScreen(
              nextScreen: HomeLayout(),
              backgroundColor: Colors.indigo,
              splash: const SplashScreen(),
              duration: 2000,
            ),
          );
        },
      ),
    );
  }
}
