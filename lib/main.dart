import 'package:flutter/material.dart';
import 'package:hive_database/dbHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final dbhelper = Databasehelper.instance;
  final textEditingController = TextEditingController();
  bool validated = true;
  String errText = '';
  String todoedited = '';
  var myItems = List();
  List<Widget> children = List<Widget>();

  Future<bool> query()async{
    myItems = [];
    children=[];
    var allRow =await dbhelper.queryall();
    allRow.forEach((row) { 
      myItems.add(row.toString());
      children.add(
        Dismissible(
          
          background: Container(color: Colors.red,),
          key: UniqueKey(),
                  child: Card(
    elevation: 2.0,
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    child: Container(
      padding: EdgeInsets.all(5.0),
      child: ListTile(
            title: Text(
              row['todo']
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
      dbhelper.deletedata(row['id']);
      setState(() {
          
      });
              },
              color: Colors.red,
            ),
          ),
    ),
  ),
        )
      );
    });
    return Future.value(true);
  }

  void addTodo() async {
    Map<String, dynamic> row = {Databasehelper.columnName: todoedited};
    final id = await dbhelper.insert(row);
    print(id);
    Navigator.pop(context);
    todoedited = '';
    setState(() {
      validated = true;
      errText = '';
    });
  }

  void showalertdialog() {
    textEditingController.text ='';
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      onChanged: (val) {
                        todoedited = val;
                      },
                      controller: textEditingController,
                      autofocus: true,
                      decoration: InputDecoration(
                          errorText: validated ? null : errText),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.purple,
                          child: Text('Add',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: () {
                            if (textEditingController.text.isEmpty) {
                              setState(() {
                                errText = 'Cant be empty';
                                validated = false;
                              });
                            } else if (textEditingController.text.length >
                                512) {
                              setState(() {
                                errText = 'To many characters';
                                validated = false;
                              });
                            } else {
                              addTodo();
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: query(),
      builder: (context, snapshot) {
      if (snapshot.hasData == null) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            strokeWidth: 0.5,
          ),
        );
      } else {
        if (myItems.length == 0) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              elevation: 0.0,
              title: Text('Tasks'),
              centerTitle: true,
            ),
            body: Center(
              child: Text('No Task Available'),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () {
                showalertdialog();
              },
              child: Icon(Icons.add),
            ),
          );
        } else{
          return 
Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        title: Text('Tasks'),
        centerTitle: true,
      ),
      body: 
      SingleChildScrollView(
        child: Column(
          children: children
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          showalertdialog();
        },
        child: Icon(Icons.add),
      ),
    );
        }
        
      }
      
    });
  }
}




