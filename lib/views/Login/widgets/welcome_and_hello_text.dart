import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeAndHelloText extends StatelessWidget {
  const WelcomeAndHelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
                            Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              "WELCOME TO PRO FITNESS!",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .01,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              "Hello there, sign in to continue",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
    ],);
  }
}