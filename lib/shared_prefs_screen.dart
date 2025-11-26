import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsScreen extends StatefulWidget {
  const SharedPrefsScreen({super.key});

  @override
  State<SharedPrefsScreen> createState() => _SharedPrefsScreenState();
}

class _SharedPrefsScreenState extends State<SharedPrefsScreen> {
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  String _displayText = 'No data yet';

  static const _keyName = 'user_name';
  static const _keyAge = 'user_age';
  static const _keyEmail = 'user_email';
  static const _keyTime = 'user_timestamp';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<void> _save() async {
    final prefs = await _prefs;
    final name = _nameCtrl.text.trim();
    final age = int.tryParse(_ageCtrl.text.trim());
    final email = _emailCtrl.text.trim();

    if (name.isEmpty) {
      setState(() => _displayText = 'Please enter a name');
      return;
    }

    await prefs.setString(_keyName, name);
    if (age != null) await prefs.setInt(_keyAge, age);
    if (email.isNotEmpty) await prefs.setString(_keyEmail, email);
    await prefs.setString(
      _keyTime,
      DateTime.now().toIso8601String(),
    );

    setState(() => _displayText = 'Saved successfully');
  }

  Future<void> _show() async {
    final prefs = await _prefs;
    final name = prefs.getString(_keyName);
    final age = prefs.getInt(_keyAge);
    final email = prefs.getString(_keyEmail);
    final timeStr = prefs.getString(_keyTime);

    if (name == null) {
      setState(() => _displayText = 'No saved name');
      return;
    }

    final buffer = StringBuffer()
      ..writeln('Name: $name');
    if (age != null) buffer.writeln('Age: $age');
    if (email != null) buffer.writeln('Email: $email');
    if (timeStr != null) {
      final dt = DateTime.tryParse(timeStr);
      if (dt != null) {
        buffer.writeln('Last saved: $dt');
      }
    }

    setState(() => _displayText = buffer.toString());
  }

  Future<void> _clear() async {
    final prefs = await _prefs;
    await prefs.remove(_keyName);
    await prefs.remove(_keyAge);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyTime);

    setState(() => _displayText = 'Data cleared');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ageCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _save,
                  child: const Text('Save Name'),
                ),
                ElevatedButton(
                  onPressed: _show,
                  child: const Text('Show Name'),
                ),
                OutlinedButton(
                  onPressed: _clear,
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Output:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_displayText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
