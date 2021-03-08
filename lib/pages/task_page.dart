import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_final/model/moor_database.dart';
import 'package:todo_final/widgets/custom_button.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

// class Task {
//   final String task;
//   final bool isFinished;
//   const Task(
//     this.task,
//     this.isFinished,
//   );
// }

// List<Task> _taskList = [
//   new Task('Call  tom about appointment', false),
//   new Task('Fix onbording experice', false),
//   new Task('Write chapter one', false),
//   new Task('setup user focus group', false),
//   new Task('Have cofee with stan', true),
//   new Task('Meet with sales', true),
// ];
// void addtask(Task task)
//    {
//      _taskList.add(task);
//    }

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
        //  final taskList = Provider.of<Database>(context);
        stream: database.watchAllTodos(),
        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
          final todos = snapshot.data ?? List();
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todoItem = todos[index];
              return _taskUncomplete(todoItem, database);

              //  snapshot.data[index].completed
              //     ? _taskComplete(snapshot.data[index])
              //     : _taskUncomplete(snapshot.data[index]);
            },
          );
        });
  }

  Widget _taskUncomplete(Todo todo, AppDatabase database) {
    return InkWell(
      onDoubleTap: () {
        doTaskCompletion(todo, database);
      },
      onLongPress: () {
        doTaskDeletion(todo, database);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, bottom: 20.0),
        child: Row(
          children: <Widget>[
            Icon(
              todo.completed
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              // color: Theme.of(context).accentColor,
              size: 20.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(todo.name),
          ],
        ),
      ),
    );
  }

  Future doTaskDeletion(Todo todo, AppDatabase database) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  "Do You want to detete",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  todo.name,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                CustomButton(
                  onPressed: () {
                    database.deleteTodo(todo);
                    Navigator.of(context).pop();
                  },
                  buttonText: "Delete",
                  color: Theme.of(context).accentColor,
                  textcolor: Colors.white,
                ),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          );
        });
  }

  Future doTaskCompletion(Todo todo, AppDatabase database) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  "COnfirm Task completion",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  todo.name,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                CustomButton(
                  onPressed: () {
                    database.updateTodo(todo.copyWith(completed: true));
                    Navigator.of(context).pop();
                  },
                  buttonText: "Complete",
                  color: Theme.of(context).accentColor,
                  textcolor: Colors.white,
                ),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          );
        });
  }

  Widget _taskComplete(Todo todo) {
    return InkWell(
      onDoubleTap: () {},
      onLongPress: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 20.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              // color: Theme.of(context).accentColor,
              size: 20.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(todo.name),
          ],
        ),
      ),
    );
  }
}
