class ChangePasswordDto {
  String oldPassword;
  String newPassword;

  ChangePasswordDto({required this.oldPassword, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
