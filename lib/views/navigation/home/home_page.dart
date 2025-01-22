import 'package:flutter/material.dart';
import 'package:flutter_application_1/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/userprofile/user_profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height * .25,
            floating: false,
            pinned: true,
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ))
            ],
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color(0xff289004),
                ),
                child: Stack(
                  children: [
                    Image.asset('assets/images/Ellipse4.png'),
                    Image.asset('assets/images/Ellipse3.png'),
                    Positioned(
                        top: MediaQuery.sizeOf(context).height * .04,
                        left: MediaQuery.sizeOf(context).width * .15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, CustomPageRoute(page: const UserProfilePage(),transitionType: TransitionType.slide));
                                },
                                icon: Image.asset('assets/images/person.png')),
                            Row(
                              children: [
                                Text(
                                  "Hello, Good Morning",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Sophia !",
                                  style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )),
                    Positioned(
                        left: MediaQuery.sizeOf(context).width * .1,
                        right: MediaQuery.sizeOf(context).width * .04,
                        top: MediaQuery.sizeOf(context).height * .18,
                        child: SearchBar(
                          leading: const Icon(
                            Icons.search_outlined,
                            color: Color(0xff303841),
                          ),
                          hintText: "Search",
                          hintStyle: WidgetStatePropertyAll(
                            Theme.of(context).textTheme.labelMedium,
                          ),
                          shape: const WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ),
          // Body after SliverAppBar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * .03,
                  horizontal: MediaQuery.sizeOf(context).width * .02),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * .05),
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * .2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff43AF00),
                              Color(0xff289004),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.sizeOf(context).height * .03,
                              right: MediaQuery.sizeOf(context).width * .1,
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Fit young woman doing ",
                                        style: GoogleFonts.bebasNeue(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Battle stretch traning",
                                          style: GoogleFonts.bebasNeue(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                          MediaQuery.sizeOf(
                                                                      context)
                                                                  .width *
                                                              .02)),
                                              backgroundColor:
                                                  const WidgetStatePropertyAll(
                                                      Color(0xffFABC06))),
                                          onPressed: () {},
                                          child: Text(
                                            "Start Exercise",
                                            style: GoogleFonts.dmSans(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Image.asset('assets/images/person2.png'),
                  Positioned(
                      top: MediaQuery.sizeOf(context).height * .14,
                      right: MediaQuery.sizeOf(context).width * .2,
                      child: Image.asset('assets/images/dumbbells.png')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
