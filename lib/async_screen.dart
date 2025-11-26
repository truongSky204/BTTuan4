import 'package:flutter/material.dart';

class AsyncScreen extends StatefulWidget {
  const AsyncScreen({super.key});

  @override
  State<AsyncScreen> createState() => _AsyncScreenState();
}

class _AsyncScreenState extends State<AsyncScreen> {
  String _message = 'Loading user...';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() {
      _message = 'User loaded successfully!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Async Exercise')),
      body: Center(
        child: Text(
          _message,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
