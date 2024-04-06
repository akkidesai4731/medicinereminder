import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WeeklyReminderPage extends StatefulWidget {
  @override
  _WeeklyReminderPageState createState() => _WeeklyReminderPageState();
}

class _WeeklyReminderPageState extends State<WeeklyReminderPage> {
  List<bool> _reminderEnabled = List.filled(7, false);
  TimeOfDay _selectedTime = TimeOfDay.now();

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
    // Implement scheduling notification logic
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
