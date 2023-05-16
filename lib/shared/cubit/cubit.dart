import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/shared/constants/constants.dart';
import 'package:to_do_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int index = 0;
  late Database database;

  void changeNavigationBarIndex(index) {
    this.index = index;
    emit(ChangeNavigationBarState());
  }

  void openDataBase() async {
    database = await openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, taskName TEXT, taskDate TEXT, taskTime TEXT, taskState TEXT)');
      },
      onOpen: (database) {
        getFromDataBase(database);
      },
    );
  }

  Future<void> insertIntoDatabase(
      {required taskName, required taskDate, required taskTime}) async {
    return await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks (taskName, taskDate, taskTime , taskState) VALUES("$taskName","$taskDate", "$taskTime","new")')
          .then((value) {
        getFromDataBase(database);
      });
    });
  }

  Future<void> getFromDataBase(Database database) async {
    List<Map> todayNewTasks = [];
    List<Map> important = [];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      allTasks = value;
      value.forEach((element) {
        if (element['taskState'] == 'important') {
          important.add(element);
        }
        if (element['taskDate'] ==
            DateFormat.yMMMd().format(
              DateTime.now(),
            )) {
          todayNewTasks.add(element);
          emit(ChangeDatabaseState());
        }
      });
      importantTasks = important;
      todayTasks = todayNewTasks;
      emit(ChangeDatabaseState());
    });
  }

  void updateDatabase({
    required String newState,
    required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET taskState = ?  WHERE id = ?',
        [newState, id]).then((value) {
      getFromDataBase(database);
    });
  }

  void deleteFromDatabase ({
  required int id,
})
  {
    database
        .rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value) => getFromDataBase(database));
  }
}
