import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'services/auth_service.dart';
import 'models/login_user_dto.dart';
import 'models/user.dart';
import 'models/register_page.dart';
import 'models/user_page.dart';
import 'models/change_password_page.dart';
import 'models/forgot_password_page.dart';
import 'models/reset_password_page.dart'; // Importa la pagina di reset della password

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    String baseUrl;
    if (kIsWeb) {
      baseUrl = 'http://localhost:8006';
    } else if (Platform.isAndroid) {
      baseUrl = 'http://10.0.2.2:8006';
    } else {
      baseUrl = 'http://localhost:8006';
    }
    authService = AuthService(baseUrl: baseUrl);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    try {
      final loginUserDto = LoginUserDto(
        email: emailController.text,
        password: passwordController.text,
      );
      final loginResponse = await authService.login(loginUserDto);
      final user = await authService.getCurrentUser(loginResponse.token);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(
            user: user,
            authService: authService,
            token: loginResponse.token,
          ),
        ),
      );
    } catch (e) {
      _showErrorDialog('Login failed');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage(authService: authService)),
                );
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage(authService: authService)),
                );
              },
              child: Text('Forgot Password'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage(authService: authService)),
                );
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final User user;
  final AuthService authService;
  final String token;

  DashboardPage({required this.user, required this.authService, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
