import 'package:flutter/material.dart';
import 'StartScreen.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'chat/chat_&_calling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ZIMKit
  ZIMKit().init(
    appID: 868416483, // your app ID
    appSign: '84ed2a7a6fa1b8a50576ff9846f42635f2c9ad4fcaa0e7584a336b5eaf94df9e', // your app Sign
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LEO Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Start at login or authentication screen
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Future<void> _loginUser() async {
    final userId = _userIdController.text.trim();
    final userName = _userNameController.text.trim();

    if (userId.isEmpty || userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid User ID and Name')),
      );
      return;
    }

    try {
      await ZIMKit().connectUser(id: userId, name: userName);
      // Navigate to chat screen upon successful login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  ChatScreen1()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEO Chat Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'User Name'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loginUser,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
