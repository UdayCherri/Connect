// history.dart
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> complaints = [
    {'id': '001', 'status': 'Unsolved', 'message': 'Mess food is cold.'},
    {'id': '002', 'status': 'Being Solved', 'message': 'Dirty plates in the dining hall.'},
    {'id': '003', 'status': 'Solved', 'message': 'Unhygienic kitchen environment.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint History"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          Color statusColor;

          // Determine status color based on complaint status
          if (complaint['status'] == 'Unsolved') {
            statusColor = Colors.red;
          } else if (complaint['status'] == 'Being Solved') {
            statusColor = Colors.yellow;
          } else {
            statusColor = Colors.green;
          }

          return Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text('Complaint ID: ${complaint['id']}'),
              subtitle: Text(complaint['message'] ?? ''),
              trailing: CircleAvatar(
                radius: 15,
                backgroundColor: statusColor,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
