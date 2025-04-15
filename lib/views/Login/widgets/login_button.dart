import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Login/data/cubit/login_cubit.dart';
import 'package:flutter_application_1/views/Login/data/model/login_request_model.dart';
import 'package:flutter_application_1/views/Login/widgets/Email_and_password_textFields_login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  if (EmailAndPasswordTextfieldsLoginPage.formKey.currentState!.validate()) {
                    BlocProvider.of<LoginCubit>(context)
                        .emitLogin(LoginRequesttModel(
                      email: EmailAndPasswordTextfieldsLoginPage.emailController.text,
                      password: EmailAndPasswordTextfieldsLoginPage.passwordController.text,
                    ));
                  }
                },
                child: const Text("LOGIN"))),
      ],
    );
  }
}
