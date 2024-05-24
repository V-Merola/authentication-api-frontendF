import 'package:flutter/material.dart';
import 'user.dart';

class UsersPage extends StatelessWidget {
  final List<User> users;

  UsersPage({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${user.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Full Name: ${user.fullName}'),
                  Text('Email: ${user.email}'),
                  Text('Role: ${user.role}'),
                  Text('Created At: ${user.createdAt}'),
                  Text('Updated At: ${user.updatedAt}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
