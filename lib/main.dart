// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/theme_notifier.dart';
import 'screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Mess Connect',
            theme: themeNotifier.currentTheme,
            home: HomePage(userId: "12345", userName: "John Doe"),
          );
        },
      ),
    );
  }
}
