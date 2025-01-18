// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SignupPage extends StatelessWidget {
//   const SignupPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//               bottom: MediaQuery.sizeOf(context).height * .03,
//               top: MediaQuery.sizeOf(context).height * .03,
//               left: MediaQuery.sizeOf(context).width * .03,
//               right: MediaQuery.sizeOf(context).width * .03),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "Create Account",
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Please enter your credentials to",
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "proceed",
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Full Name",
//                     style: Theme.of(context).textTheme.labelLarge,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               TextFormField(
//                 cursorColor: const Color(0xff289004),
//                 decoration: InputDecoration(
//                     hintText: "John Welles",
//                     hintStyle: Theme.of(context).textTheme.labelMedium),
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Phone",
//                     style: Theme.of(context).textTheme.labelLarge,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               TextFormField(
//                 cursorColor: const Color(0xff289004),
//                 decoration: InputDecoration(
//                     hintText: "0103651478",
//                     hintStyle: Theme.of(context).textTheme.labelMedium),
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Email address",
//                     style: Theme.of(context).textTheme.labelLarge,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               TextFormField(
//                 cursorColor: const Color(0xff289004),
//                 decoration: InputDecoration(
//                     hintText: "johnwelles@gmail.com",
//                     hintStyle: Theme.of(context).textTheme.labelMedium),
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Password",
//                     style: Theme.of(context).textTheme.labelLarge,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               TextFormField(
//                 cursorColor: const Color(0xff289004),
//                 decoration: InputDecoration(
//                     hintText: "*****",
//                     hintStyle: Theme.of(context).textTheme.labelMedium),
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .03,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: ElevatedButton(
//                           onPressed: () {},
//                           child: const Text("Create Account"))),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .03,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Or Register with",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .02,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: ElevatedButton(
//                           style: const ButtonStyle(
//                               backgroundColor:
//                                   WidgetStatePropertyAll(Color(0xffF5F5F5))),
//                           onPressed: () {},
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.sizeOf(context).width * .05),
//                             child: Row(
//                               children: [
//                                 Image.asset("assets/images/google.png"),
//                                 SizedBox(
//                                   width: MediaQuery.sizeOf(context).width * .2,
//                                 ),
//                                 Text("Connect with Google",
//                                     style: GoogleFonts.montserrat(
//                                         color: const Color(0xff303841),
//                                         fontSize: 18)),
//                               ],
//                             ),
//                           ))),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .01,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: ElevatedButton(
//                           style: const ButtonStyle(
//                               backgroundColor:
//                                   WidgetStatePropertyAll(Color(0xff4267B2))),
//                           onPressed: () {},
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.sizeOf(context).width * .05),
//                             child: Row(
//                               children: [
//                                 Image.asset("assets/images/facebook.png"),
//                                 SizedBox(
//                                   width: MediaQuery.sizeOf(context).width * .2,
//                                 ),
//                                 Text("Connect with Facebook",
//                                     style: GoogleFonts.montserrat(
//                                         color: Colors.white, fontSize: 18)),
//                               ],
//                             ),
//                           ))),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .03,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Already have an acount?",
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text("Login!"))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
            expandedHeight: MediaQuery.sizeOf(context).height*.2,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Create Account", style: Theme.of(context).textTheme.titleLarge),
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
                    right: MediaQuery.sizeOf(context).width * .03
                  ),
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Create Account",
                      //       style: Theme.of(context).textTheme.titleLarge,
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Please enter your credentials to",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "proceed",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
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
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "John Welles",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Phone",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "0103651478",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
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
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "johnwelles@gmail.com",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
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
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "*****",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .03),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Create Account"))),
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Or Register with",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(Color(0xffF5F5F5))),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.sizeOf(context).width * .05),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/google.png"),
                                        SizedBox(width: MediaQuery.sizeOf(context).width * .2),
                                        Text("Connect with Google",
                                            style: GoogleFonts.montserrat(
                                                color: const Color(0xff303841),
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(Color(0xff4267B2))),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.sizeOf(context).width * .05),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/facebook.png"),
                                        SizedBox(width: MediaQuery.sizeOf(context).width * .2),
                                        Text("Connect with Facebook",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white, fontSize: 18)),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .03),
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
    );
  }
}

