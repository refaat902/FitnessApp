import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pageview/pageview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  //  HttpOverrides.global = MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [
    //     // BlocProvider(create: (context) => ServicesCubit()),
    //     // BlocProvider(create: (context)=>GetMyUnitCubit()),
    //     // BlocProvider(create: (context)=>MyfamilyCubit()),
    //     // BlocProvider(create: (context)=>ServiceTypeCubit()),
    //     // BlocProvider(create: (context)=>GetProfileInfoCubit()),
    //     // BlocProvider(create: (context)=>GetWalletHistoryCubit()),
    //     // BlocProvider(create: (context)=>GetWalletBalanceCubit()),
    //     // BlocProvider(create: (context)=>GetServicesHistoryCubit()),
    //     // BlocProvider(create: (context)=>MyCarCubit()),
    //   ],
    //   child:
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Color(0xffFCFCFC),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black)),
        inputDecorationTheme: InputDecorationTheme(

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xff289004),
              )),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * .026,
              horizontal: MediaQuery.sizeOf(context).width * .06),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff696969)),
              borderRadius: BorderRadius.circular(10)),
          fillColor: const Color(0xffF5F5F5),
        ),
        scaffoldBackgroundColor: const Color(0xffFCFCFC),
        textTheme: TextTheme(
            titleLarge: GoogleFonts.bebasNeue(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.normal),
            labelLarge: GoogleFonts.montserrat(
                color: const Color(0xff3A4750),
                fontSize: 25,
                fontWeight: FontWeight.w500),
            labelMedium: GoogleFonts.montserrat(
                color: const Color(0xff303841),
                fontWeight: FontWeight.w500,
                fontSize: 20),
            bodySmall: GoogleFonts.dmSans(
                color: const Color(0xff3A4750),
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: const WidgetStatePropertyAll(Colors.black),
                textStyle: WidgetStatePropertyAll(GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w600)))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*.02)),
                foregroundColor: const WidgetStatePropertyAll(Colors.white),
                textStyle: WidgetStatePropertyAll(
                  GoogleFonts.bebasNeue(
                    fontSize: 24, fontWeight: FontWeight.normal)),
                backgroundColor:
                    const WidgetStatePropertyAll(Color(0xff289004)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))))),
      ),
      debugShowCheckedModeBanner: false,
      home: const PageViewWithSlider(),
    );
  }
}
