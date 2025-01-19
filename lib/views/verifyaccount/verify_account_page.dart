import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Signup/signup_page.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyAccountPage extends StatelessWidget {
  const VerifyAccountPage({super.key});

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
              title: Text("Verify Account",
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
                      Row(
                        children: [
                          Text(
                            "Verify your account by entering verifition",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "code we sent to ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                  text: "johnwelles@gmail.com",
                                  style: GoogleFonts.dmSans(
                                      color: const Color(0xff289004),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .02,
                      ),
                      OtpTextField(
                        cursorColor:
                            const Color(0xff289004), 
                        textStyle: const TextStyle(
                          color: Color(0xff289004),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ), 
                        numberOfFields: 4,
                        fieldWidth: MediaQuery.sizeOf(context).width*.2, 
                        borderRadius:
                            BorderRadius.circular(10),
                        borderColor:
                            const Color(0xff289004), 
                        focusedBorderColor:
                            const Color(0xff289004), 
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {},
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {},
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
