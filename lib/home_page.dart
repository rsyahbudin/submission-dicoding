import 'package:flutter/material.dart';
import 'add_task_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _tasks = [];
  bool _isDarkTheme = false;
  bool _showCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _addTask(Map<String, dynamic> task) {
    setState(() {
      _tasks.add(task);
    });
    _saveTasks();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  void _toggleCompleted() {
    setState(() {
      _showCompleted = !_showCompleted;
    });
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskStrings = prefs.getStringList('tasks');
    if (taskStrings != null) {
      setState(() {
        _tasks = taskStrings.map((taskString) {
          return Map<String, dynamic>.from(taskString as Map);
        }).toList();
      });
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = _tasks.map((task) {
      return task.toString();
    }).toList();
    prefs.setStringList('tasks', taskStrings);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: _toggleTheme,
            ),
            IconButton(
              icon: const Icon(Icons.check_box),
              onPressed: _toggleCompleted,
            ),
          ],
        ),
        body: _tasks.isEmpty
            ? const Center(child: Text('No tasks added.'))
            : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  if (!_showCompleted && _tasks[index]['completed'] == true) {
                    return Container();
                  }

                  return ListTile(
                    title: Text(
                      _tasks[index]['task'],
                      style: TextStyle(
                          decoration: _tasks[index]['completed']
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    subtitle: Text('Category: ${_tasks[index]['category']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            setState(() {
                              _tasks[index]['completed'] = !_tasks[index]['completed'];
                            });
                            _saveTasks();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _tasks.removeAt(index);
                            });
                            _saveTasks();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final task = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskPage()),
            );
            if (task != null) {
              _addTask(task);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
