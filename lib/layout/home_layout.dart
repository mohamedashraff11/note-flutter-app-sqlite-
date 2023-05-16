import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/constants/constants.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/shared/cubit/states.dart';
import 'package:to_do_app/ui/all_tasks_screen/all_tasks_screen.dart';
import 'package:to_do_app/ui/home_body/home_body.dart';
import 'package:to_do_app/ui/important_tasks_screen/important_tasks_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  List<Widget> screens = [
    HomeBody(),
    AllTasks(),
    const ImportantTasks(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..openDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeNavigationBarIndex(index);
                },
                elevation: 0.0,
                currentIndex: cubit.index,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.house,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.clear_all_rounded,
                    ),
                    label: 'All Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    label: 'Important ',
                  ),
                ],
                selectedItemColor: defaultColor,
                iconSize: 25,
              ),
              body: screens[cubit.index],
            );
          }),
    );
  }
}
