import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/components/shared_components.dart';
import 'package:to_do_app/shared/constants/constants.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/shared/cubit/states.dart';

class AllTasks extends StatelessWidget {
  AllTasks({Key? key}) : super(key: key);

  Icon icon = const Icon(Icons.star_border);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.clear_all,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'All Tasks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListView.separated(
                          itemBuilder: (context, count) => defaultTaskViewer(
                                list: allTasks,
                                count: count,
                                context: context,
                              ),
                          separatorBuilder: (context, count) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: allTasks.length),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
