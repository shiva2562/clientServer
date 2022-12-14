import 'package:bloc/bloc.dart';
import 'package:clientserver/Model/login_model.dart';
import 'package:clientserver/Repository/login_repository.dart';
import 'package:meta/meta.dart';

import '../../Services/exceptions.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = LoginRepository();
  LoginBloc() : super(LoginInitial()) {
    on<RequestLogin>((event, emit) async {
      try {
        emit(LoginLoading());
        LoginModel loginModel =
            await _loginRepository.login(event.userName, event.password);
        if (loginModel.message == "") {
          emit(LoginFailure(loginModel.message));
        } else {
          emit(LoginSuccess());
        }
      } catch (error) {
        emit(error is AppException
            ? LoginFailure(error.toString())
            : LoginFailure('something went wrong'));
      }
    });
  }
}
