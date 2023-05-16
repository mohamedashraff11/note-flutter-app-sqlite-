import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/components/shared_components.dart';
import 'package:to_do_app/shared/constants/constants.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';
import 'package:to_do_app/shared/cubit/states.dart';

class ImportantTasks extends StatelessWidget {
  const ImportantTasks({Key? key}) : super(key: key);

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
                        children: [
                          Container(
                            color: Colors.white,
                            child: Icon(
                              Icons.star,
                              color: defaultColor,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Important Tasks',
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
                              list: importantTasks,
                              count: count,
                              context: context),
                          separatorBuilder: (context, count) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: importantTasks.length),
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
