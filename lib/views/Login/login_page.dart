import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/Login/data/cubit/login_cubit.dart';
import 'package:flutter_application_1/views/Login/widgets/Email_and_password_textFields_login_page.dart';
import 'package:flutter_application_1/views/Login/widgets/forgot_password_button.dart';
import 'package:flutter_application_1/views/Login/widgets/login_button.dart';
import 'package:flutter_application_1/views/Login/widgets/welcome_and_hello_text.dart';
import 'package:flutter_application_1/views/Signup/data/cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/views/Signup/signup_page.dart';
import 'package:flutter_application_1/views/navigation/navigation_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          await SharedPrefService.setUserLoggedIn(true);
          await SharedPrefService.saveToken(state.loginData.token.toString());
          Navigator.push(context, CustomPageRoute(page: const NavigationPage(),transitionType: TransitionType.slide));
          
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              expandedHeight: MediaQuery.sizeOf(context).height * .2,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("login",
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
                      right: MediaQuery.sizeOf(context).width * .03,
                    ),
                    child: Column(
                      children: [
                        const WelcomeAndHelloText(),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * .02,
                        ),
                        const EmailAndPasswordTextfieldsLoginPage(),
                        const ForgotPasswordButton(),
                        const LoginButton(),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * .03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an acount?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          page: BlocProvider(
                                            create: (context) =>
                                                getIt<SignUpCubit>(),
                                            child: const SignupPage(),
                                          ),
                                          transitionType: TransitionType.fade));
                                },
                                child: const Text("Register!"))
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
