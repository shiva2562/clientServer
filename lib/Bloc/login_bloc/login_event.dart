part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class RequestLogin extends LoginEvent {
  String userName;
  String password;
  RequestLogin(this.userName, this.password);
}
