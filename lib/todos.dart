import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Todos extends StatefulWidget {
  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final db = Firestore.instance;
  String userID = '';
  String todo;
  bool isComplete = false;
  TextEditingController _textEditingController = TextEditingController();

  void addTodo() {
    try {
      db.collection('todos').document().setData({
        'todo': todo,
        'is_completed': isComplete,
      }).then((todo) {
        print('todo added');
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[400]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TodoList',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.add_box),
                            title: TextField(
                              controller: _textEditingController,
                              onChanged: (value) {
                                setState(() {
                                  todo = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a new todo'),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                if (todo != null) {
                                  addTodo();
                                  _textEditingController.text = "";
                                  setState(() {
                                    todo = null;
                                  });
                                }
                              },
                              child: Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('todos').snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final todos = snapshot.data.documents.reversed;
                          List<Column> todoWidgets = [];
                          for (var todo in todos) {
                            final todoname = todo.data['todo'];
                            final todo_completed = todo.data['is_completed'];
                            final todo_id = todo.documentID;
                            final todoWidget = Column(
                              children: <Widget>[
                                ListTile(
                                  leading: todo_completed
                                      ? Icon(
                                          Icons.done_all,
                                          color: Colors.blue,
                                        )
                                      : Icon(
                                          Icons.done,
                                          color: Colors.grey,
                                        ),
                                  title: GestureDetector(
                                    onTap: () {
                                      db
                                          .collection('todos')
                                          .document(todo_id)
                                          .updateData({
                                        'is_completed': !todo_completed
                                      });
                                    },
                                    child: Text(
                                      '$todoname',
                                      style: TextStyle(
                                        decoration: todo_completed == true
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      db
                                          .collection('todos')
                                          .document(todo_id)
                                          .delete();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            );
                            todoWidgets.add(todoWidget);
                          }
                          return ListView(
                            children: todoWidgets,
                          );
                        } else {
                          return Center(child: Text('Add something here!!'));
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
