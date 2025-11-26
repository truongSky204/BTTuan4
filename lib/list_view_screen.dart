import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Tạo danh sách contact giả
    final contacts = List.generate(
      20,
          (i) => _Contact(
        name: 'Contact ${i + 1}',
        phone: '0900 000 ${i.toString().padLeft(2, '0')}',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Contacts'),
      ),
      body: ListView.separated(
        itemCount: contacts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final c = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(
                c.name.substring(0, 1), // chữ cái đầu
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(c.name),
            subtitle: Text(c.phone),
          );
        },
      ),
    );
  }
}

// model nhỏ cho contact
class _Contact {
  final String name;
  final String phone;
  _Contact({required this.name, required this.phone});
}
