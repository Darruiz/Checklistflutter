import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(ChecklistApp());
}

class ChecklistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist Diários',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChecklistScreen(),
    );
  }
}

class ChecklistScreen extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  FlutterLocalNotificationsPlugin _notifications;
  TextEditingController _taskController;
  List<String> _tasks;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _tasks = [];
    _initializeNotifications();
  }

  void _initializeNotifications() {
    _notifications = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: ios);
    _notifications.initialize(initSettings);
  }

  Future<void> _showNotification(String title, String body) async {
    final android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      importance: Importance.high,
    );
    final ios = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: ios);
    await _notifications.show(0, title, body, platform);
  }

  void _addTask() {
    final task = _taskController.text;
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task);
        _taskController.clear();
        _scheduleNotification(task); // Agendar notificação para a nova tarefa
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _scheduleNotification(String task) {
    const int notificationId = 0;
    const String notificationTitle = 'Checklist Diários';
    final String notificationBody = 'Lembre-se de realizar a tarefa: "$task"';

    final android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      importance: Importance.high,
    );
    final ios = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: ios);

    final DateTime now = DateTime.now();
    final DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute +
          1, // Agendar a notificação para 1 minuto a partir do momento atual
    );

    _notifications.zonedSchedule(
      notificationId,
      notificationTitle,
      notificationBody,
      scheduledTime,
      platform,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist Diários'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeTask(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Adicionar tarefa',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
