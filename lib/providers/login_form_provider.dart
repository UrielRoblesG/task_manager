import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _passwordVisibility = false;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set passwordVisibility(bool value) {
    _passwordVisibility = value;
    notifyListeners();
  }

  void onChangeVisibility() {
    passwordVisibility = !passwordVisibility;
  }

  String get username => _username;

  String get password => password;

  bool get passwordVisibility => _passwordVisibility;

  bool isValid() {
    return formKey.currentState?.validate() ?? false;
  }
}
