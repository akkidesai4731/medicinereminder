import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart'; // Import NotificationService

class WeeklyReminderScreen extends StatefulWidget {
  @override
  _WeeklyReminderScreenState createState() => _WeeklyReminderScreenState();
}

class _WeeklyReminderScreenState extends State<WeeklyReminderScreen> {
  List<bool> _reminderEnabled = List.filled(7, false);
  TimeOfDay _selectedTime = TimeOfDay.now();
  late NotificationService _notificationService; // Declare NotificationService instance

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService(); // Initialize NotificationService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Reminder'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < 7; i++)
                CheckboxListTile(
                  title: Text(_getDayOfWeek(i)),
                  value: _reminderEnabled[i],
                  onChanged: (value) {
                    setState(() {
                      _reminderEnabled[i] = value!;
                    });
                  },
                ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Select Reminder Time',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.alarm),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _selectedTime = pickedTime;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveReminders,
                child: Text('Save Reminders'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDayOfWeek(int index) {
    switch (index) {
      case 0:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return '';
    }
  }

  void _saveReminders() {
    for (int i = 0; i < 7; i++) {
      if (_reminderEnabled[i]) {
        _scheduleNotification(i);
      } else {
        _cancelNotification(i);
      }
    }
    _showSnackbar('Reminders saved successfully');
  }

  void _scheduleNotification(int dayOfWeek) {
    // Use NotificationService instance to schedule notification
    _notificationService.showNotification('Medicine Name', _selectedTime);
  }

  void _cancelNotification(int dayOfWeek) {
    // Implement canceling notification logic
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
