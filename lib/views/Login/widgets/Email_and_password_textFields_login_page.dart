// ignore: file_names
import 'package:flutter/material.dart';


class EmailAndPasswordTextfieldsLoginPage extends StatelessWidget {
  const EmailAndPasswordTextfieldsLoginPage({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Email address",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .01,
          ),
          TextFormField(
            controller: emailController,
            cursorColor: const Color(0xff289004),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "johnwelles@gmail.com",
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                return "Please enter a valid email";
              }
              return null;
            },
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .01,
          ),
          Row(
            children: [
              Text(
                "Password",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .01,
          ),
          TextFormField(
            controller: passwordController,
            cursorColor: const Color(0xff289004),
            obscureText: true,
            decoration: InputDecoration(
              hintText: "*****",
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              } else if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

