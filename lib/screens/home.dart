// home.dart
import 'package:flutter/material.dart';
import 'complaint.dart';  // Import ComplaintPage
import 'history.dart';    // Import HistoryPage
import 'settings.dart';   // Import SettingsPage
import 'theme_notifier.dart';

class HomePage extends StatefulWidget {
  final String userId;
  final String userName;

  HomePage({required this.userId, required this.userName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current index of the bottom navigation

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to different pages based on the tapped icon
    if (index == 2) { // Third icon (Complaints)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ComplaintPage()),
      );
    }
    else if (index == 3) { // Fourth icon (History)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HistoryPage()),
      );
    }
    else if (index == 4) { // Last icon (Settings)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green, // User profile image placeholder
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userId,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  widget.userName,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: 5, // Replace this with dynamic data
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: ListTile(
              title: Text(
                'Notice ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('This is the content of notice ${index + 1}.'),
              leading: Icon(Icons.notifications, color: Colors.blue),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xFF00BFFF),
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped, // Handle the bottom navigation item taps
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.add, color: Colors.blue, size: 28),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}
