class LoginUserDto {
  final String email;
  final String password;

  LoginUserDto({
    required this.email,
    required this.password,
  });

  factory LoginUserDto.fromJson(Map<String, dynamic> json) {
    return LoginUserDto(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
