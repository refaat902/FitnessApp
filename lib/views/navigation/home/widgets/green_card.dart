import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/back_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/chest_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/legs_cubit.dart';
import 'package:flutter_application_1/views/startexe/start_exe_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GreenCard extends StatelessWidget {
  const GreenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .03),
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
                  colors: [Color(0xff43AF00), Color(0xff289004)],
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
                      children: [
                        Text(
                          "Fit young woman doing",
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Battle stretch training",
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.sizeOf(context).width * .02,
                              ),
                            ),
                            backgroundColor:
                                const WidgetStatePropertyAll(Color(0xffFABC06)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(
                                page: MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                        create: (context) =>
                                            getIt<ChestCubit>()),
                                    BlocProvider(
                                      create: (context) => getIt<BackCubit>(),
                                    ),
                                    BlocProvider(
                                        create: (context) =>
                                            getIt<LegsCubit>()),
                                  ],
                                  child: const StartExePage(),
                                ),
                                transitionType: TransitionType.slide,
                              ),
                            );
                          },
                          child: Text(
                            "Start Exercise",
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset('assets/images/person2.png'),
          Positioned(
            top: MediaQuery.sizeOf(context).height * .14,
            right: MediaQuery.sizeOf(context).width * .2,
            child: Image.asset('assets/images/dumbbells.png'),
          ),
        ],
      ),
    );
  }
}
