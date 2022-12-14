import 'package:clientserver/Bloc/degrees_bloc/degrees_bloc.dart';
import 'package:clientserver/Bloc/fields_bloc/fields_bloc.dart';
import 'package:clientserver/Bloc/login_bloc/login_bloc.dart';
import 'package:clientserver/presentation/degrees_screen/degrees_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController? usernameController;
  final TextEditingController? passwordController;
  const LoginButton(this.usernameController, this.passwordController,
      {super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => DegreesBloc(),
                        ),
                        BlocProvider(
                          create: (context) => FieldsBloc(),
                        ),
                      ],
                      child: DegreesPage("success"),
                    )),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoginFailure) {
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  String user = widget.usernameController?.text ?? "";
                  String pass = widget.passwordController?.text ?? "";

                  BlocProvider.of<LoginBloc>(context)
                      .add(RequestLogin(user, pass));
                },
                child: const Text("Login"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Login Failed",
                style: TextStyle(color: Colors.red),
              )
            ],
          );
        }
        return ElevatedButton(
          onPressed: () {
            String user = widget.usernameController?.text ?? "";
            String pass = widget.passwordController?.text ?? "";

            BlocProvider.of<LoginBloc>(context).add(RequestLogin(user, pass));
          },
          child: const Text("Login"),
        );
      },
    );
  }
}
