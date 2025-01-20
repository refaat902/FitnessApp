// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/views/Signup/signup_page.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: const Text("Login"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(
//             top: MediaQuery.sizeOf(context).height * .03,
//             left: MediaQuery.sizeOf(context).width * .03,
//             right: MediaQuery.sizeOf(context).width * .03),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "WELCOME TO PRO FITNESS!",
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .01,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Hello there, sign in to",
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   "continue",
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .02,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Email address",
//                   style: Theme.of(context).textTheme.labelLarge,
//                 )
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .01,
//             ),
//             TextFormField(
//               cursorColor: const Color(0xff289004),
//               decoration: InputDecoration(
//                   hintText: "johnwelles@gmail.com",
//                   hintStyle: Theme.of(context).textTheme.labelMedium),
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .02,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Password",
//                   style: Theme.of(context).textTheme.labelLarge,
//                 )
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .01,
//             ),
//             TextFormField(
//               cursorColor: const Color(0xff289004),
//               decoration: InputDecoration(
//                   hintText: "*****",
//                   hintStyle: Theme.of(context).textTheme.labelMedium),
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .01,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                     onPressed: () {}, child: const Text("Forgot Password?"))
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .02,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: ElevatedButton(
//                         onPressed: () {}, child: const Text("LOGIN"))),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .03,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Or Login with",
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 )
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .02,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: ElevatedButton(
//                         style: const ButtonStyle(
//                             backgroundColor:
//                                 WidgetStatePropertyAll(Color(0xffF5F5F5))),
//                         onPressed: () {},
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal:
//                                   MediaQuery.sizeOf(context).width * .05),
//                           child: Row(
//                             children: [
//                               Image.asset("assets/images/google.png"),
//                               SizedBox(
//                                 width: MediaQuery.sizeOf(context).width * .2,
//                               ),
//                               Text("Connect with Google",
//                                   style: GoogleFonts.montserrat(
//                                       color: const Color(0xff303841),
//                                       fontSize: 14)),
//                             ],
//                           ),
//                         ))),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .01,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: ElevatedButton(
//                         style: const ButtonStyle(
//                             backgroundColor:
//                                 WidgetStatePropertyAll(Color(0xff4267B2))),
//                         onPressed: () {},
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal:
//                                   MediaQuery.sizeOf(context).width * .05),
//                           child: Row(
//                             children: [
//                               Image.asset("assets/images/facebook.png"),
//                               SizedBox(
//                                 width: MediaQuery.sizeOf(context).width * .2,
//                               ),
//                               Text("Connect with Facebook",
//                                   style: GoogleFonts.montserrat(
//                                       color: Colors.white, fontSize: 14)),
//                             ],
//                           ),
//                         ))),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.sizeOf(context).height * .03,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Don't have an acount?",
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SignupPage(),
//                           ));
//                     },
//                     child: const Text("Register!"))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Signup/signup_page.dart';
import 'package:flutter_application_1/views/forgotpass/forgot_pass_page.dart';
import 'package:flutter_application_1/views/questions/age/age_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              title:
                  Text("login", style: Theme.of(context).textTheme.titleLarge),
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
                            "WELCOME TO PRO FITNESS!",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Hello there, sign in to",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "continue",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .02,
                      ),
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
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "johnwelles@gmail.com",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
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
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "*****",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassPage(),
                                    ));
                              },
                              child: const Text("Forgot Password?"))
                        ],
                      ),
                      // SizedBox(
                      //   height: MediaQuery.sizeOf(context).height * .01,
                      // ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AgePage(),));
                                  },
                                  child: const Text("LOGIN"))),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Or Login with",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .01,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color(0xffF5F5F5))),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.sizeOf(context).width *
                                                .05),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/google.png"),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  .2,
                                        ),
                                        Text("Connect with Google",
                                            style: GoogleFonts.montserrat(
                                                color: const Color(0xff303841),
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .01,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color(0xff4267B2))),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.sizeOf(context).width *
                                                .05),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/facebook.png"),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  .2,
                                        ),
                                        Text("Connect with Facebook",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
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
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ));
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
    );
  }
}
