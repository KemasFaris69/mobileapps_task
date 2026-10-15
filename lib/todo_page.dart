import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Map<String, dynamic>> _todos = [
    {'title': 'contoh 1', 'done': true},
    {'title': 'contoh 2', 'done': false},
    {'title': 'contoh 3', 'done': true},
    {'title': 'contoh 4', 'done': false},
    {'title': 'contoh 5', 'done': false},
  ];

  final _controller = TextEditingController();

  int get _remaining => _todos.where((t) => t['done'] == false).length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTodo(int index, bool value){
    setState(() {
      _todos[index]['done'] = value;
    });
  }

  void _deleteTodo(int index){
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _addTodo() {
    final text = _controller.text.trim();

    if(text.isEmpty){
      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
        SnackBar(content: Text('Isi Task'),
          backgroundColor: Colors.black54,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.white,
        ),
      );
    }

    setState(() {
      _todos.add({'title': text, 'done': false}),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  .0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your To Do',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
                SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
    
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (_) => _addTodo(),
                        style: TextStyle(
                          fontSize: 14, 
                          color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'add New Task',
                            hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.2),
                              
                          ),
                      ),
                    ),
                    ),
                    SizedBox(width: 12),
                    Material(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.add, color: Colors.white, size: 22),
                        
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20),
                for(int i = 0; i < _todos.length; i++)
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                    children: [
                      SizedBox(width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _todos[i]['done'],
                        activeColor: Colors.blueGrey,
                        side: BorderSide(
                      
                          color: Colors.blueGrey,
                          width: 1.5
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)
                        ),
                        onChanged: (v) => _toggleTodo(i, v ?? false),
                      ),
                    ),
                    SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _todos[i]['title'],
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                      InkWell(
                        onTap: () => _deleteTodo(i),
                        child: Icon(Icons.close, size: 16, color: Colors.black,
                        ),
                        
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('your remaining todos :  + $_remaining',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,  fontStyle: FontStyle.italic, color: Colors.black),

                
                ),
            ],
          ),
        ),
      ),
    );
  }
}