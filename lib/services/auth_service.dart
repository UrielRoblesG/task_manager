import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late SharedPreferences prefs;

  Future<bool> initialize() async {
    try {
      prefs = await SharedPreferences.getInstance();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String?> hasToken() async {
    try {
      final token = prefs.getString('token');

      return token != null ? token : null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String?> loggin() async {
    try {
      final token =
          'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
      Future.delayed(const Duration(milliseconds: 1500));
      await prefs.setString('token', token);

      return token;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      await prefs.remove('token');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
