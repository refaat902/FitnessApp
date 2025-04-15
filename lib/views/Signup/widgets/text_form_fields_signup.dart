import 'package:flutter/material.dart';

class TextFormFieldsSignup extends StatefulWidget {
  static final formKey = GlobalKey<FormState>();
  static final fullNameController = TextEditingController();
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final confirmPasswordController = TextEditingController();
  static final phoneController = TextEditingController();
  const TextFormFieldsSignup({super.key});

  @override
  State<TextFormFieldsSignup> createState() => _TextFormFieldsSignupState();
}

class _TextFormFieldsSignupState extends State<TextFormFieldsSignup> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: TextFormFieldsSignup.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Full Name",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .01),
          TextFormField(
            controller: TextFormFieldsSignup.fullNameController,
            cursorColor: const Color(0xff289004),
            decoration: InputDecoration(
              hintText: "John Welles",
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Full name is required';
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .01),
          Row(
            children: [
              Text(
                "Email address",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .01),
          TextFormField(
            controller: TextFormFieldsSignup.emailController,
            cursorColor: const Color(0xff289004),
            decoration: InputDecoration(
              hintText: "johnwelles@gmail.com",
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .01),
          Row(
            children: [
              Text(
                "Password",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .01),
          TextFormField(
            controller: TextFormFieldsSignup.passwordController,
            obscureText: true,
            cursorColor: const Color(0xff289004),
            decoration: InputDecoration(
              hintText: "*****",
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .01),
          Row(
            children: [
              Text(
                "Confirm Password",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .01),
          TextFormField(
            controller: TextFormFieldsSignup.confirmPasswordController,
            obscureText: true,
            cursorColor: const Color(0xff289004),
            decoration: InputDecoration(
              hintText: "*****",
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
            validator: (value) {
              if (value != TextFormFieldsSignup.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
