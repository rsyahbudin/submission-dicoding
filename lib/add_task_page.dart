import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();
  String _category = 'Personal';
  String _priority = 'Low';
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task'),
            ),
            DropdownButtonFormField<String>(
              value: _category,
              onChanged: (value) {
                setState(() {
                  _category = value!;
                });
              },
              items: ['Personal', 'Work', 'Shopping', 'Others']
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Category'),
            ),
            DropdownButtonFormField<String>(
              value: _priority,
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
              items: ['Low', 'Medium', 'High']
                  .map((priority) => DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Priority'),
            ),
            ListTile(
              title: Text(_dueDate == null
                  ? 'Select Due Date'
                  : 'Due Date: ${_dueDate!.toLocal()}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dueDate = pickedDate;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    'task': _taskController.text,
                    'category': _category,
                    'priority': _priority,
                    'dueDate': _dueDate?.toString(),
                    'completed': false,
                  });
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
