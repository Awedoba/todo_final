import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 70)();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getAllTodos() => select(todos).get();
  Stream<List<Todo>> watchAllTodos() => select(todos).watch();
  Future insertTodo(Todo todo) => into(todos).insert(todo);
  Future updateTodo(Todo todo) => update(todos).replace(todo);
  Future deleteTodo(Todo todo) => delete(todos).delete(todo);
}
