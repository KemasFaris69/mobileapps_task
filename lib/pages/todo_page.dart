import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> _todos = [];
  final _controller = TextEditingController();

  int get _remaining => _todos.where((t) => !t.done).length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTodo(int index, bool value) {
    setState(() {
      _todos[index].done = value;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _addTodo() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Isi Task'),
            backgroundColor: Colors.black54,
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: Colors.white,
          ),
        );
      return;
    }

    setState(() {
      _todos.add(Todo(text));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your To Do',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _addTodo(),
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'add New Task',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton.filled(
                    onPressed: _addTodo,
                    icon: const Icon(Icons.add, color: Colors.white, size: 22),
                    tooltip: 'Tambah',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black54,
                      fixedSize: const Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _todos.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada task, tambahkan dulu',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _todos.length,
                        itemBuilder: (context, i) => TodoItem(
                          todo: _todos[i],
                          onToggle: (v) => _toggleTodo(i, v),
                          onDelete: () => _deleteTodo(i),
                        ),
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                'your remaining todos : $_remaining',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
