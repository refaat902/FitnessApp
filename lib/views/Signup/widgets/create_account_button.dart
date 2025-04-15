import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Signup/data/cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/views/Signup/data/models/signup_request_model.dart';
import 'package:flutter_application_1/views/Signup/widgets/text_form_fields_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  if (TextFormFieldsSignup.formKey.currentState!.validate()) {
                    BlocProvider.of<SignUpCubit>(context)
                        .emitCreateNewUSer(SignUpRequestModel(
                      fullName: TextFormFieldsSignup.fullNameController.text,
                      email: TextFormFieldsSignup.emailController.text,
                      password: TextFormFieldsSignup.passwordController.text,
                      confirmPassword:TextFormFieldsSignup.confirmPasswordController.text,
                    ));
                  }
                },
                child: const Text("Create Account"))),
      ],
    );
  }
}
