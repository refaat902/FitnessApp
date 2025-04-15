import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/forgotpass/forgot_pass_page.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                      page: const ForgotPassPage(),
                      transitionType: TransitionType.fade));
            },
            child: const Text("Forgot Password?"))
      ],
    );
  }
}
