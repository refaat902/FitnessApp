import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/verifyaccount/verify_account_page.dart';

class ForgotPassPage extends StatelessWidget {
  const ForgotPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: AutoSizeText("Forgot Password",
                  maxLines: 1, style: Theme.of(context).textTheme.titleLarge),
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
                      Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              'Please enter your email below to receive your password reset code',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .02,
                      ),
                      Row(
                        children: [
                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .01,
                      ),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "johnwelles@gmail.com",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .05,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            page: const VerifyAccountPage(),
                                            transitionType:
                                                TransitionType.fade));
                                  },
                                  child: const Text("rest password"))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
