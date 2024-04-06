import 'package:flutter/material.dart';

class MonthlyReminderPage extends StatefulWidget {
  final Function(String) onSaveReminder;

  MonthlyReminderPage(this.onSaveReminder);

  @override
  _MonthlyReminderPageState createState() => _MonthlyReminderPageState();
}

class _MonthlyReminderPageState extends State<MonthlyReminderPage> {
  String _selectedDay = '1';
  TextEditingController _reminderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Monthly Reminder'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Day:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedDay,
              onChanged: (String? value) {
                setState(() {
                  _selectedDay = value!;
                });
              },
              items: List.generate(
                31,
                    (index) => DropdownMenuItem<String>(
                  value: (index + 1).toString(),
                  child: Text((index + 1).toString()),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter Reminder Name:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _reminderNameController,
              decoration: InputDecoration(
                hintText: 'Reminder Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String reminderName = _reminderNameController.text.trim();
                if (reminderName.isNotEmpty) {
                  String reminder = 'On $_selectedDay: $reminderName';
                  widget.onSaveReminder(reminder);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a reminder name')),
                  );
                }
              },
              child: Text('Save Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
