import 'package:flutter/material.dart';

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

  void showalertdialog(){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          'Add Task'
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              autofocus: true,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
   
                RaisedButton(
                  color: Colors.purple,
                  child: Text('Add',style: TextStyle( color:Colors.white,)),
                  onPressed: (){},)
              ],
            )
          ],
        ),
      )
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        title: Text('Tasks'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
   myCard('change it')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: (){
          showalertdialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget myCard(String task){
  return Card(
    elevation: 5.0,
    margin: EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 10.0
    ),
    child: Container(
      padding:EdgeInsets.all(5.0),
      child: ListTile(
        title: Text('$task'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: (){
            print('deleted');
          }, 
          color: Colors.red, ),
      ),
    ),
  );
}

