class RegisterUserDto {
  final String email;
  final String password;
  final String fullName;

  RegisterUserDto({
    required this.email,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
    };
  }
}
