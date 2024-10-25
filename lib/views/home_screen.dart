import 'package:code_lab3apps/views/tambahdata_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_lab3apps/views/edit_task_screen.dart';
import 'package:code_lab3apps/views/delete_task_screen.dart';
import 'package:code_lab3apps/views/LoginPage.dart'; // Import halaman login

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy list of tasks to represent your task data
  List<String> tasks = List.generate(10, (index) => 'Task ${index + 1}');

  void _tambahData() {
    // Navigate to TambahDataScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahDataScreen(onTaskAdded: (newTask) {
          setState(() {
            tasks.add(newTask); // Add the new task to the list
          });
        }),
      ),
    );
  }

  void _logout() {
    // Implement logout functionality here
    // For example, navigate back to LoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Call _logout when pressed
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length, // Use the length of tasks list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]),
            trailing: PopupMenuButton(
              onSelected: (value) async {
                if (value == 'edit') {
                  // Navigate to EditTaskScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(
                        taskId: '', // Pass data from the selected task
                      ),
                    ),
                  );
                } else if (value == 'delete') {
                  // Navigate to DeleteTaskScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteTaskScreen(
                        taskId: '', // Pass data from the selected task
                      ),
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahData, // Call _tambahData to add a new task
        child: Icon(Icons.add),
      ),
    );
  }
}
