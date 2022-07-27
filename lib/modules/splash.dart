import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo1/shared/Cubit/cubit.dart';
import 'package:todo1/shared/Cubit/states.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return const Image(
          image: AssetImage('assets/images/playstore.png'),
        );
      },
    );
  }
}

