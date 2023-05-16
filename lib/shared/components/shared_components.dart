import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/shared/constants/constants.dart';
import 'package:to_do_app/shared/cubit/cubit.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required bool showKeyboard,
  required TextInputType? keyboardType,
  onTap,
  required validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      label: Text(label),
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
    ),
    keyboardType: keyboardType,
    onTap: onTap,
    readOnly: !showKeyboard,
    validator: validator,
  );
}

Widget defaultTextButton({
  required onPressed,
  required String buttonName,
}) {
  return TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
      padding: MaterialStateProperty.all<EdgeInsetsDirectional>(
          const EdgeInsetsDirectional.only(
              start: 40.0, end: 40.0, top: 15.0, bottom: 15.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    ),
    child: Text(
      buttonName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}

Widget defaultTaskViewer({
  required list,
  required count,
  required BuildContext context,
}) {
  return Dismissible(
    key: Key("${list[count]['id']}"),
    onDismissed: (direction){
         AppCubit.get(context).deleteFromDatabase(id: list[count]['id']);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 1, color: Colors.black12, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                '${list![count]['taskTime']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${list![count]['taskDate']}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 35,
            width: 1,
            color: Colors.black54,
          ),
          Expanded(
            child: Text(
              '${list![count]['taskName']}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (list[count]['taskState'] == 'important') {
                AppCubit.get(context)
                    .updateDatabase(newState: 'new', id: list[count]['id']);
              } else {
                AppCubit.get(context)
                    .updateDatabase(newState: 'important', id: list[count]['id']);
              }
            },
            icon: ConditionalBuilder(
              condition: list[count]['taskState'] == 'important',
              builder: (context) => const Icon(
                Icons.star,
                color: Colors.blue,
              ),
              fallback: (context) => const Icon(Icons.star_border),
            ),
          ),
        ],
      ),
    ),
  );
}
