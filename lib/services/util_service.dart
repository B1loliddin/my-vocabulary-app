sealed class UtilService {
  static bool validateSignUp(
    String userName,
    String email,
    String password,
    String confirmPassword,
  ) {
    return userName.isNotEmpty &&
        email.length >= 6 &&
        password.isNotEmpty &&
        password == confirmPassword;
  }

  static bool validateSignIn(String email, String password) {
    return email.length >= 6 && password.length >= 4;
  }
}
