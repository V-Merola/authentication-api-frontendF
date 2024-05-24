import 'package:flutter/material.dart';
import 'package:login_register/models/user_page.dart';
import '../models/user.dart';
import '../models/change_password_page.dart';
import '../services/auth_service.dart';

class UserInfoPage extends StatelessWidget {
  final User user;
  final AuthService authService;
  final String token;

  UserInfoPage({required this.user, required this.authService, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('ID: ${user.id}'),
            Text('Full Name: ${user.fullName}'),
            Text('Email: ${user.email}'),
            Text('Role: ${user.role}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordPage(authService: authService, token: token),
                  ),
                );
              },
              child: Text('Modifica Password'),
            ),
            if (user.role == 'ADMIN')
              ElevatedButton(
                onPressed: () async {
                  final users = await authService.getAllUsers(token);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsersPage(users: users)),
                  );
                },
                child: Text('Mostra tutti gli utenti'),
              ),
          ],
        ),
      ),
    );
  }
}
