import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/components/shared_components.dart';
import 'package:to_do_app/shared/constants/constants.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/shared/cubit/states.dart';
import '../add_tasks_screen/add_tasks_screen.dart';

class HomeBody extends StatelessWidget {
  HomeBody({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        key: scaffoldKey,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 35),
                    decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.elliptical(250, 35),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                top: 50,
                start: 20,
                end: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'What are you going to do ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          scaffoldKey.currentState!
                              .showBottomSheet((context) => AddNewTask());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('ADD-TO-DO'),
                              Icon(Icons.add),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Today Tasks You Should Do',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, count) => defaultTaskViewer(
                              list: todayTasks,
                              count: count,
                              context: context,
                            ),
                        separatorBuilder: (context, count) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: todayTasks.length),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
