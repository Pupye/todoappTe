import 'package:flutter/material.dart';

void main()=> runApp(new TodoApp());



class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: new TodoList()
    );
  }
}


class TodoList extends StatefulWidget{ 
  @override
  createState()=> TodoListState();
}


class TodoListState extends State <TodoList>{
  
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    if(task.length > 0 ){
      setState(()=> _todoItems.add(task) );
    }
  }

  void _removeTodoItem (int index){
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('cancel'),
              onPressed: ()=>Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('Mark as done'),
              onPressed: (){
                _removeTodoItem(index);
                Navigator.of(context).pop();

              },
            )
          ],
        );
      }
    );
  }

  Widget _buildTodoList(){
    return new ListView.builder(
      itemBuilder: (context, index){
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      }
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: ()=> _promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build (BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Task',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen(){
    Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute(
      builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task to this app')
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
              hintText: 'aaaasasdasdasdaaa',
              contentPadding: const EdgeInsets.all(16.0)
            ),
          )
        );
      }
    )
  );
  }
}