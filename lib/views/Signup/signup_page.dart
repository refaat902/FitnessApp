import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Signup/data/cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/views/Signup/widgets/create_account_button.dart';
import 'package:flutter_application_1/views/Signup/widgets/enter_credentials_text.dart';
import 'package:flutter_application_1/views/Signup/widgets/text_form_fields_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
@override
Widget build(BuildContext context) {
  return BlocListener<SignUpCubit, SignUpState>(
    listener: (context, state) {
      if (state is CreateNewUSerSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created successfully!"),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          // ignore: use_build_context_synchronously
          Navigator.pop(context); 
        });
      }
    },
    child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: MediaQuery.sizeOf(context).height * .2,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Create Account",
                  style: Theme.of(context).textTheme.titleLarge),
              background: Container(color: const Color(0xffFCFCFC)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * .03,
                      top: MediaQuery.sizeOf(context).height * .03,
                      left: MediaQuery.sizeOf(context).width * .03,
                      right: MediaQuery.sizeOf(context).width * .03),
                  child: Column(
                    children: [
                      const EnterCredentialsText(),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      const TextFormFieldsSignup(),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .03),
                      const CreateAccountButton(),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Login!"))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
