class AppValidator {
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*?[A-Z])'
    r'(?=.*?[a-z])'
    r'(?=.*?[0-9])'
    r'(?=.*?[!@#\$&*~])'
    r'.{8,}$',
  );

  static bool isPasswordStrong(String password) {
    return passwordRegex.hasMatch(password);
  }
}
