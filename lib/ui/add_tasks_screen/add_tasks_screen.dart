import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/shared/components/shared_components.dart';
import 'package:to_do_app/shared/constants/constants.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';

class AddNewTask extends StatelessWidget {
  AddNewTask({Key? key}) : super(key: key);

  var taskName = TextEditingController();
  var taskDate = TextEditingController();
  var taskTime = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadiusDirectional.circular(20),
                    ),
                    child: const Text(
                      'Add New Task',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: taskName,
                    keyboardType: TextInputType.text,
                    label: 'Task Name',
                    icon: Icons.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Task Name Can\'t Be Empty';
                      }
                    },
                    showKeyboard: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      controller: taskDate,
                      keyboardType: TextInputType.datetime,
                      label: 'Task Date',
                      icon: Icons.date_range,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Task Date Can\'t Be Empty';
                        }
                      },
                      showKeyboard: false,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        ).then((value) =>
                            taskDate.text = DateFormat.yMMMd().format(value!));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: taskTime,
                    keyboardType: TextInputType.datetime,
                    label: 'Task Date',
                    icon: Icons.watch_later_outlined,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Task Time Can\'t Be Empty';
                      }
                    },
                    showKeyboard: false,
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) =>
                              taskTime.text = value!.format(context));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      defaultTextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        buttonName: 'Cancel',
                      ),
                      const Spacer(),
                      defaultTextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context)
                                .insertIntoDatabase(
                                    taskName: taskName.text,
                                    taskDate: taskDate.text,
                                    taskTime: taskTime.text)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          }
                        },
                        buttonName: '  Add  ',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
