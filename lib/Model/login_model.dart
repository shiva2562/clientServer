import 'dart:convert';

class LoginModel {
  String message;
  LoginModel.fromJson(Map<String, dynamic> json) : message = json['message'];
}
