import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_user_dto.dart';
import '../models/register_user_dto.dart';
import '../models/login_response.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<LoginResponse> login(LoginUserDto loginUserDto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginUserDto.toJson()),
      );

      print('Request body: ${jsonEncode(loginUserDto.toJson())}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> register(RegisterUserDto registerUserDto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(registerUserDto.toJson()),
      );

      print('Request body: ${jsonEncode(registerUserDto.toJson())}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to register');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<User> getCurrentUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Token: $token');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List<User>> getAllUsers(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/admin/all'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> changePassword(String token, String oldPassword, String newPassword) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/me/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      print('Request body: ${jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      })}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      print('Request body: ${jsonEncode({'email': email})}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to request password reset');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
  Future<void> resetPassword(String token, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token, 'newPassword': newPassword}),
      );

      print('Request body: ${jsonEncode({'token': token, 'newPassword': newPassword})}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to reset password');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
