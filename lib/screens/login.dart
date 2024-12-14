import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'home.dart'; // Adjust the import path if necessary

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn();
  late Excel _excelData;

  @override
  void initState() {
    super.initState();
    _loadExcelData();
  }

  Future<void> _loadExcelData() async {
    ByteData data = await rootBundle.load('assets/validity.xlsx');
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);
    setState(() {
      _excelData = excel!;
    });
  }

  bool _validateCredentials(String id, String password) {
    final sheet = _excelData.sheets.values.first;
    for (var row in sheet.rows) {
      // Skip rows where ID or Password is null
      if (row[0]?.value == null || row[1]?.value == null) {
        continue; // Skip blank rows
      }

      if (row[0]?.value.toString().trim() == id.trim() &&
          row[1]?.value.toString().trim() == password.trim()) {
        return true;
      }
    }
    return false;
  }

  bool _validateGoogleEmail(String email) {
    final sheet = _excelData.sheets.values.first;
    for (var row in sheet.rows) {
      if (row[2]?.value != null && row[2]?.value.toString().trim() == email.trim()) {
        return true; // Email exists in the system
      }
    }
    return false; // Email not found
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        bool isValid = _validateGoogleEmail(account.email);
        if (isValid) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login Successful')));
        } else {
          _showError('Email not found in system.');
        }
      }
    } catch (error) {
      _showError('Google Sign-In failed: $error');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/Login-B.png', // New logo for login screen
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Login to your account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: 'ID Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue, // Button background color
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: () {
                bool isValid = _validateCredentials(
                    idController.text, passwordController.text);
                if (isValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Successful')));
                  // Navigate to HomePage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userId: idController.text, // Pass user ID
                        userName: 'User Name', // Use actual name here
                      ),
                    ),
                  );
                } else {
                  _showError('Invalid credentials');
                }
              },
              child: Text('Login'),
            ),
            Divider(),
            Text(
              '- or login with -',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _handleGoogleSignIn,
              child: Image.asset(
                'assets/google_icon.png', // Add Google icon to assets
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
