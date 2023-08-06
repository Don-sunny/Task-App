import 'package:flutter/material.dart';
import 'package:task_app/screens/add_task_screen.dart';
import 'package:task_app/screens/completed_task_screen.dart';
import 'package:task_app/screens/favorite_task_screen.dart';
import 'package:task_app/screens/my_drawer.dart';
import 'package:task_app/screens/pending_task_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  static const id = 'tabs_screen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTaskScreen(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTasksSCreen(), 'title': 'Completed Task'},
    {'pageName': const FavoriteTasksScreen(), 'title': 'Favorite Task'},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageDetails[_selectedPageIndex]['title'],
        ),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: (value) {
            setState(() {
              _selectedPageIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp),
              label: 'Pending Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Completed Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite Tasks',
            )
          ]),
    );
  }
}
